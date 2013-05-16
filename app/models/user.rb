class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def friends
    # facebook.get_connections('me', 'friends').map{|friend| self.facebook.get_object(friend['id'])}
    facebook.fql_query('SELECT name, pic_square, uid FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1=me())')
  end

  def search(term)
    @results = {}
    ['name', 'work', 'education', 'interests', 'name', 'contact_email', 'current_location'].each do |field|
      result = facebook.fql_query('SELECT name, pic_square, uid FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1=me()) and strpos(lower(' + field + '),' + ' "' + term + '") >= 0')
      @results[field] = result if result.present?
    end
    @results
  end


  def friends_by_location
    facebook.fql_query('SELECT name, current_location.city, pic_square, uid FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1=me())').group_by{|u| u['current_location']}.reject!{ |k| k == nil }.sort_by{ |u| u[1].count }.reverse
  end

  def friends_by_mutual
    facebook.fql_query('SELECT name, pic_square, mutual_friend_count, uid FROM user WHERE uid IN(SELECT uid2 FROM friend WHERE uid1=me()) order by mutual_friend_count desc limit 50')
  end

  def high_school_friends
    query(self.high_school, 'education')
  end

  def college_friends
    query(self.college, 'education')
  end

  def grad_school_friends
    query(self.grad_school, 'education')
  end

  def high_school
    school('High School')
  end

  def college
    school('College')
  end

  def grad_school
    school('Graduate School')
  end

  def query(user_attr, field)
    facebook.fql_query('SELECT name, pic_square, uid FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1=me()) and"' + user_attr  + '"in ' + field)
  end

  def get_relevant_friends(college, grad_school, high_school)
    @results = facebook.fql_multiquery({"friends" => 'SELECT uid2 FROM friend WHERE uid1=me()', "mutual" => "SELECT name, pic_square, mutual_friend_count, uid FROM user WHERE uid IN( select uid2 from #friends ) order by mutual_friend_count desc limit 50", "college" => "SELECT name, pic_square, uid FROM user WHERE uid in ( select uid2 from #friends ) and '" + college.to_s + "' in education", "grad school" => "SELECT name, pic_square, uid FROM user WHERE uid in ( select uid2 from #friends ) and '" + grad_school.to_s + "' in education", "high school" => "SELECT name, pic_square, uid FROM user WHERE uid in ( select uid2 from #friends ) and '" + high_school.to_s + "' in education", "friends_list" => 'SELECT name, pic_square FROM user WHERE uid IN(select uid2 from #friends)' })
  end

  def school(type)
    if facebook.get_object('me')['education'].present?
      if facebook.get_object('me')['education'].select{|x| x['type']==(type)}.try(:first)
        facebook.get_object('me')['education'].select{|x| x['type']==(type)}.first['school']['name']
      else
        nil
      end
    else
      nil
    end
  end

end
