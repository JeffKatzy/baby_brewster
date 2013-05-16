class FriendsController < ApplicationController
  def search
    @results = @current_user.search(params['search'])
    @keys = @results.keys
  end

  def show
    @friend = @current_user.facebook.get_object(params['id'])
    @picture = @current_user.facebook.get_picture(params['id'])
  end
end