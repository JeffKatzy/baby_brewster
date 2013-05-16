class SearchController < ApplicationController
  layout 'application'
  def search
    @results = @current_user.search(params['search'])
    @keys = @results.keys
  end

  def get_friend
  end
end