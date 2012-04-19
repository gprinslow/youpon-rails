class AddIsManagerToEmployees < ActiveRecord::Migration
  def up
    add_column :employees, :is_manager, :boolean
    remove_column :employees, :type
  end

  def down
    remove_column :employees, :is_manager
    add_column :employees, :type, :string
  end
end
