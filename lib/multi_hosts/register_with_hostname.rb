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
        user_host_attributes = {multi_host_id: @current_multihost.id}



        if @current_multihost.default_group
          @current_multihost.default_group.users << @user
        end

        if User.column_names.include?('easy_user_type_id')
          user_host_attributes[:easy_user_type_id] = @current_multihost.default_easy_user_type_id
        end

        @user.update_attributes(user_host_attributes)
      end
    end
  end
end