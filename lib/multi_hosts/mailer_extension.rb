module MultiHosts
  module MailerExtension

    extend ActiveSupport::Concern

    included do
      after_action :set_multi_host_urls
    end

    def set_multi_host_urls
      if non_default_host_user_present? || Thread.current[:current_multi_host]
        default_host = MultiHost.default.full_hostname
        user_multi_host = Thread.current[:current_multi_host] || non_default_host_users.first.multi_host
        target_host  = user_multi_host.full_hostname

        if user_multi_host.default_mail_from.present?
          message.from = user_multi_host.default_mail_from
        end

        binding.pry

        [:html_part, :text_part].each do |partname|
          mcontent = message.send(partname).body.raw_source
          message.send(partname).body.raw_source.replace(mcontent.gsub(default_host, target_host))
        end
      end
    end

    def all_recipients
      [message.to, message.cc, message.bcc].flatten.compact.uniq
    end

    def all_recipient_users
      @_all_recipient_users ||= ::EmailAddress.where(address: all_recipients).map(&:user).uniq
    end

    def non_default_host_user_present?
      non_default_host_users.any?
    end

    def non_default_host_users
      @_non_default_host_users ||= all_recipient_users.select(&:non_default_host_user?)
    end

  end
end
