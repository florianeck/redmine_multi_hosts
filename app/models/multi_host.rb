class MultiHost < ActiveRecord::Base

  validates :full_hostname, format: { with: URI.regexp }, uniqueness: true

  before_save :extract_full_hostname_parts, :check_for_default

  belongs_to :default_group, :class_name => "Group", :foreign_key => "default_group_id"

  if defined?(EasyUserType)
    belongs_to :default_easy_user_type, :class_name => "EasyUserType", :foreign_key => "default_easy_user_type_id"
  end

  def self.default
    find_by(is_default: true) || raise("Please run rake multi_hosts:setup_default_host to setup default data")
  end

  def default_group_name
    default_group.try(:name)
  end

  def default_easy_user_type_name
    defined?(EasyUserType) ? default_easy_user_type.try(:name) : nil
  end

  private

  def check_for_default
    current_default = self.class.find_by(is_default: true)

    if current_default && is_default? && current_default != self
      self.errors.add(:is_default, 'only one default allowed')
      return false
    end
  end

  def extract_full_hostname_parts
    begin
      uri = URI.parse(full_hostname)
      self.protocol     = uri.scheme
      self.host         = uri.host
      self.port         = uri.port
      # is actually the sub uri, but ActionMailer#default_host_options calls it 'script_name'
      # ignoring root path ('/') or blank ('')
      self.script_name  = uri.path if uri.path.size >= 2
      self.internal_name = self.host.gsub('www.', '').gsub('.', '-').parameterize
    rescue Exception => e
      self.errors.add(:full_hostname, 'invalid host name')
      return false
    end
  end

end