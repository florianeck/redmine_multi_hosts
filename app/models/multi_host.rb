class MultiHost < ActiveRecord::Base


  validates :full_hostname, format: { with: URI.regexp }

  before_save :extract_full_hostname_parts


  def extract_full_hostname_parts
    begin
      uri = URI.parse(full_hostname)
      self.protocol     = uri.scheme
      self.host         = uri.host
      self.port         = uri.port
      # is actually the sub uri, but ActionMailer#default_host_options calls it 'script_name'
      # ignoring root path ('/') or blank ('')
      self.script_name  = uri.path if uri.path.size >= 2
    rescue Exception => e
      self.errors.add(:full_hostname, 'invalid host name')
      return false
    end
  end

end