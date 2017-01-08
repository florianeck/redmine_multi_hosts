module MultiHosts
  module RegisterWithHostname
    extend ActiveSupport::Concern

    included do
      before_filter :store_multi_host_name_for_thread, only: :register
      after_filter :set_user_multihost_id, only: :register
    end

    private

    def store_multi_host_name_for_thread
      @current_multihost = MultiHost.find_by(host: request.env['HTTP_HOST'])
      if @current_multihost
        Thread.current[:current_multi_host] = @current_multihost
      end
    end

    def set_user_multihost_id
      @current_multihost = MultiHost.find_by(host: request.env['HTTP_HOST'])

      if @user && @user.persisted? && @current_multihost
        @user.update_column(:multi_host_id, @current_multihost.id)
      end
    end
  end
end