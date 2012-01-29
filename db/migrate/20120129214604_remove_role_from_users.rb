class RemoveRoleFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :role_id
    remove_column :users, :role_type
  end

  def down
    add_column :users, :role_type, :string
    add_column :users, :role_id, :integer
  end
end
