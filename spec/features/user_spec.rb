require 'spec_helper'

describe 'subscribers' do
  describe 'GET /subscribers/new', js: true do
    #it 'creates three test users' do
    #    @uri = URI.escape("https://graph.facebook.com/520443487993370/accounts/test-users?%20installed=
    #true%20&name=Jeff%20&locale=en_US%20&permissions=read_stream%20&method
    #=post%20&access_token=520443487993370|N3jPz3a992aKBG0WsYEkxjuRL90").to_s
        #https://graph.facebook.com/520443487993370/accounts/test-users?
        # installed=true&name=Jeffrey&locale=en_US%20&permissions=read_stream%20&method=post&access_token=520443487993370|N3jPz3a992aKBG0WsYEkxjuRL90
      #Email: jeffrey_qcbhzdi_jeffrey@tfbnw.net
      #Password: JeKatz1
      #@url = HTTParty.get(@uri)
      #@response = Hashie::Mash.new(@url)
      #@login_urls = @response.data.map(&:login_url)
      #visit(@login_urls.first)
      #binding.pry
    #end

    it 'will login a user' do
      visit 'http://www.facebook.com'
      fill_in('Email', :with => 'jeffrey_qcbhzdi_jeffrey@tfbnw.net')
      fill_in('Pass', :with => 'JeKatz1')
      click_button('Log In')
      Capybara.app_host = 'http://www.lvh.me:3000'
      visit ('/')
      click_link('Connect with facebook')
      binding.pry
      click_button('Okay')
      page.should have_button('Search')
    end

    it 'displays the create subscriber button' do


      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:facebook] =
      Hashie::Mash.new({"provider"=>"facebook",
 "uid"=>"1305863",
 "info"=>
  {"nickname"=>"jeffrey.e.katz",
   "email"=>"jek2141@columbia.edu",
   "name"=>"Jeffrey Katz",
   "first_name"=>"Jeffrey",
   "last_name"=>"Katz",
   "image"=>"http://graph.facebook.com/1305863/picture?type=square",
   "urls"=>{"Facebook"=>"http://www.facebook.com/jeffrey.e.katz"},
   "verified"=>true},
 "credentials"=>
  {"token"=>
    "CAAHZAVzE6PhoBANYwslCLE0hL46t4bFVODcD8p96AlwLz83KJclFKZAzMAtuhUYxyuefFpdNTrOJW2rwAZCdZAOiDHLiZBq",
   "expires_at"=>1375803788,
   "expires"=>true},
 "extra"=>
  {"raw_info"=>
    {"id"=>"1305863",
     "name"=>"Jeffrey Katz",
     "first_name"=>"Jeffrey",
     "last_name"=>"Katz",
     "link"=>"http://www.facebook.com/jeffrey.e.katz",
     "username"=>"jeffrey.e.katz",
     "hometown"=>
      {"id"=>"101881036520836", "name"=>"Philadelphia, Pennsylvania"},
     "quotes"=>
      "Don't be so humble, you're not that great",
     "education"=>
      [{"school"=>
         {"id"=>"108111879217154", "name"=>"William Tennent High School"},
        "year"=>{"id"=>"194603703904595", "name"=>"2003"},
        "type"=>"High School"},
       {"school"=>{"id"=>"21489041474", "name"=>"Duke University"},
        "year"=>{"id"=>"140617569303679", "name"=>"2007"},
        "concentration"=>
         [{"id"=>"108180979203954", "name"=>"Economics"},
          {"id"=>"104045469631213", "name"=>"Political Science"}],
        "type"=>"College"},
       {"school"=>{"id"=>"103127603061486", "name"=>"Columbia University"},
        "year"=>{"id"=>"144044875610606", "name"=>"2011"},
        "type"=>"Graduate School"}],
     "gender"=>"male",
     "email"=>"jek2141@columbia.edu",
     "timezone"=>-4,
     "locale"=>"en_GB",
     "verified"=>true,
     "updated_time"=>"2013-01-16T06:25:36+0000"}}})

      @uri = URI.escape("https://graph.facebook.com/520443487993370/accounts/test-users?%20installed=
  true%20&name=Jeff%20&locale=en_US%20&permissions=read_stream%20&method
  =post%20&access_token=520443487993370|N3jPz3a992aKBG0WsYEkxjuRL90").to_s
      @url = HTTParty.get(@uri)
      @response = Hashie::Mash.new(@url)
      @login_urls = @response.data.map(&:login_url)
      visit @login_urls.first
      binding.pry
      visit root_path
      click_link('Connect with facebook')
      page.should have_button('Search')
      #page.find("input[value='Search']").should_not be_nil
    end
  end



  #describe 'POST /subscribers' do
  #  it 'creates a new subscriber', :js => true do
  #    visit root_path
  #    click_link('Register')
  #    fill_in('Username', :with => 'Bob')
  #    fill_in('Email', :with => 'bob@gmail.com')
  #    binding.pry
  #    save_and_open_page
  #  end
  #end
end