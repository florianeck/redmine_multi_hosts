Redmine::Plugin.register :redmine_multi_hosts do
  name 'Redmine MultiHosts'
  author 'Florian Eck for akquinet'
  description 'Allow to use one Redmine installation with multiple hosts via reverse proxy'
  version '1.0'
end

require "multi_hosts/mailer_extension"
require "multi_hosts/user_extension"
require "multi_hosts/hooks"
require "multi_hosts/detect_host"
require "multi_hosts/multi_hosts_helper"

begin
  EasyUserType
rescue Exception
  # call EasyUserType to make shure its defined?
end


Rails.application.config.after_initialize do
  Mailer.send(:include, MultiHosts::MailerExtension)
  User.send(:include, MultiHosts::UserExtension)

  ApplicationController.send(:include, MultiHosts::DetectHost)
  AccountController.send(:include, MultiHosts::RegisterWithHostname)

  Redmine::MenuManager.map :admin_menu do |menu|
    menu.push :multi_hosts, :multi_host_settings_path, :caption => :multi_hosts, :html => {:class => 'icon icon-integrate'}, :if => Proc.new {User.current.admin?}
  end


  ApplicationHelper.module_eval do
    def html_title(*args)

      app_title = @current_multihost.try(:app_title) || Setting.app_title
      if args.empty?
        title = @html_title || []
        title << @project.name if @project
        title << app_title unless app_title == title.last
        title.reject(&:blank?).join(' - ')
      else
        @html_title ||= []
        @html_title += args
      end
    end
  end
end