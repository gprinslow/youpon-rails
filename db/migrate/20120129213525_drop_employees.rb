class DropEmployees < ActiveRecord::Migration
  def change
    drop_table :employees
  end
end
