class UsersController < ApplicationController
  layout 'application'
  def index
    @query_results = @current_user.get_relevant_friends(@current_user.college, @current_user.grad_school, @current_user.high_school)
    @top_cities = @current_user.friends_by_location
    @top_city = @top_cities.first[0]['city']
    @top_city_friends = @top_cities.first[1][0..4]
    @friends_by_mutual = @query_results['mutual'][0..4]
    @college_friends = @query_results['college'][0..4]
    @grad_school_friends = @query_results['grad school'][0..4]
    @high_school_friends = @query_results['high school'][0..4]
    @friends = @query_results['friends_list'][0..4]
  end

  def city
    @top_cities = @current_user.friends_by_location
    @title = @top_cities.first[0]['city']
    @friends = @top_cities.first[1]
  end

  def mutual
    @friends = @current_user.friends_by_mutual
    @title = 'Mutual Friends'
  end

  def grad_school
    @friends = @current_user.grad_school_friends
    @title = @current_user.grad_school
  end

  def college
    @friends = @current_user.college_friends
    @title = @current_user.college
  end

  def high_school
    @friends = @current_user.high_school_friends
    @title = @current_user.high_school
  end

  def friends
    @friends = @current_user.friends
    @title = 'Friends'
  end
end