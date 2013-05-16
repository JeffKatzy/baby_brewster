class SearchController < ApplicationController
  def search
    @results = @current_user.search(params['search'])
    @keys = @results.keys
  end

  def get_friend
    binding.pry
  end
end