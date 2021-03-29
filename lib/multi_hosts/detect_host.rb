module MultiHosts
  module DetectHost
    extend ActiveSupport::Concern

    included do
      before_action :detect_multi_host
    end

    private

    def detect_multi_host
      if session[:current_multi_host_name].nil?
        @current_multihost = MultiHost.find_by(host: request.env['HTTP_HOST'])
        if @current_multihost.nil?
          session[:current_multi_host_name] = 'unknown'
        elsif @current_multihost.is_default?
          session[:current_multi_host_name] = 'default'
        else
          session[:current_multi_host_name] = Thread.current[:current_multi_host_name] = @current_multihost.internal_name
        end
      end
    end
  end
end
