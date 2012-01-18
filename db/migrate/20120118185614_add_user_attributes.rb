class AddUserAttributes < ActiveRecord::Migration
  def up
    add_column :users, :name, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
  end

  def down
    remove_column :users, :name, :string
    remove_column :users, :birthday, :date
    remove_column :users, :gender, :string
  end
end
