OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = HomeController.action(:index)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], scope: 'user_location, friends_location, user_education_history, friends_education_history, friends_interests, friends_activities', :display => 'popup'
end