class CreateMultiHosts < ActiveRecord::Migration[4.2]

  def up
    create_table :multi_hosts, force: true do |t|
      t.string  :full_hostname
      t.string  :protocol
      t.string  :host
      t.integer :port
      t.string  :script_name
      t.boolean :is_default
      t.string  :internal_name
      t.timestamps
    end

    unless column_exists?(:users, :multi_host_id)
      add_column :users, :multi_host_id, :integer
    end
  end

  def down
    drop_table :multi_hosts
    remove_column :users, :multi_host_id
  end

end
