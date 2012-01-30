class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :customer_id
      t.integer :offer_id
      t.integer :status_id
      t.string :type

      t.timestamps
    end
  end
end
