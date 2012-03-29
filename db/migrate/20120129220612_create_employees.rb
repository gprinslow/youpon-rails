class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :role_id
      t.integer :merchant_id

      t.timestamps
    end
  end
end
