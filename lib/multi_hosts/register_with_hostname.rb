module MultiHosts
  module RegisterWithHostname
    extend ActiveSupport::Concern

    included do
      after_filter :set_user_multihost_id, only: :register
    end

    private

    def set_user_multihost_id
      @current_multihost = MultiHost.find_by(host: request.env['HTTP_HOST'])

      if @user && @user.persisted? && @current_multihost
        @user.update_column(:multi_host_id, @current_multihost.try(:id))
      end
    end
  end
end