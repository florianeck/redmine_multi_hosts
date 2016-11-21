module MultiHosts

  module MailerExtension

    extend ActiveSupport::Concern

    included do
      after_action :set_multi_host_urls
    end

    def set_multi_host_urls
      original_url_options = default_url_options

      [:html_part, :text_part].each do |partname|
        mcontent = message.send(partname).body.raw_source

        message.send(partname).body.raw_source.replace "AWESOME"
      end


    end

  end

end
