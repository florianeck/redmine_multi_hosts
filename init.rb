Redmine::Plugin.register :multi_hosts do
  name 'AutoDeputy'
  author 'Florian Eck for akquinet'
  description 'Allow to use one Redmine installation with multiple hosts via reverse proxy'
  version '1.0'
end

require "multi_hosts/mailer_extension"
require "multi_hosts/user_extension"

Rails.application.config.after_initialize do
  Mailer.send(:include, MultiHosts::MailerExtension)
  User.send(:include, MultiHosts::UserExtension)
end