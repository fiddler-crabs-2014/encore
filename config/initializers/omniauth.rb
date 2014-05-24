OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['705031782872346'], ENV['4e4cc978e291cc2eaa55b86a736bac96']
end
