namespace :multi_hosts do

  desc 'Setup default MultiHost entry bases on current Redmine config'
  task :setup_default_host => :environment do
    default_host = MultiHost.create(full_hostname: "#{Setting.protocol}://#{Setting.host_name}/", is_default: true)

    if default_host.persisted?
      User.update_all(multi_host_id: default_host.id)
    end
  end

end