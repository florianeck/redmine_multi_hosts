module MultiHosts
  module UserExtension

    extend ActiveSupport::Concern

    included do
      belongs_to :multi_host
    end


    def default_host_user?
      self.multi_host.try(:is_default?)
    end

    def non_default_host_user?
      !default_host_user?
    end

  end
end