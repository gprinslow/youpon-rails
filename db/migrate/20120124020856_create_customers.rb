class CreateCustomers < ActiveRecord::Migration
  def change
    drop_table :customers
    create_table :customers do |t|
      t.integer :role_id

      t.timestamps
    end
  end
end
