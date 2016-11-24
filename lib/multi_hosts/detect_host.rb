module MultiHosts
  module DetectHost
    extend ActiveSupport::Concern

    included do
      before_filter :detect_multi_host
    end

    private

    def detect_multi_host
      if session[:current_multi_host_name].nil?
        multihost = MultiHost.find_by(host: request.env['REMOTE_HOST'])
        if multihost.nil?
          session[:current_multi_host_name] = 'unknown'
        elsif multihost.is_default?
          session[:current_multi_host_name] = 'default'
        else
          session[:current_multi_host_name] = multihost.internal_name
        end
      end
    end
  end
end