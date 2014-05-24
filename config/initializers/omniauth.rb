# OmniAuth.config.logger = Rails.logger

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, ENV['705031782872346'], ENV['4e4cc978e291cc2eaa55b86a736bac96']
# end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '705031782872346', '4e4cc978e291cc2eaa55b86a736bac96', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
