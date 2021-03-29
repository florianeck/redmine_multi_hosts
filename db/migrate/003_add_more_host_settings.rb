class AddMoreHostSettings < ActiveRecord::Migration[4.2]

  def change
    add_column :multi_hosts, :default_group_id, :integer
    add_column :multi_hosts, :default_easy_user_type_id, :integer
  end

end
