class AddTitleAndEmailAdress < ActiveRecord::Migration

  def change
    add_column :multi_hosts, :default_mail_from, :string
    add_column :multi_hosts, :app_title, :string
  end

end