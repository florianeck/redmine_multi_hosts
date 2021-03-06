namespace :multi_hosts do

  desc 'Setup default MultiHost entry bases on current Redmine config'
  task :setup_default_host => :environment do
    default_host = MultiHost.create(full_hostname: "#{Setting.protocol}://#{Setting.host_name}/", is_default: true)

    if default_host.persisted?
      User.update_all(multi_host_id: default_host.id)
    end
  end

  desc "Adds a new MultiHost entry. Please format http://example.com/ (include trailing slash)"
  task :add_host, [:hostname] => :environment do |t, args|

    if args[:hostname].last != "/"
      raise ArgumentError, "Please include trailing slash in URL '#{args[:hostname]}'"
    else

      h = MultiHost.new(full_hostname: args[:hostname])

      if h.save
        puts "Added Hostname #{args[:hostname]}"
      else
        puts h.errors.inspect
      end
    end
  end

  desc "setup for stylessheets"
  task :setup_stylesheets => :environment do
    # Create stylesheets
    MultiHost.all.each do |h|
      unless File.exists?("#{Rails.root}/plugins/redmine_multi_hosts/assets/stylesheets/#{h.internal_name}.css")
        FileUtils.cp("#{Rails.root}/plugins/redmine_multi_hosts/assets/stylesheets/example.css", "#{Rails.root}/plugins/redmine_multi_hosts/assets/stylesheets/#{h.internal_name}.css")
      end
    end

  end

end