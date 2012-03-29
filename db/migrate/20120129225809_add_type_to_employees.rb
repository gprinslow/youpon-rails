class AddTypeToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :type, :string
  end
end
