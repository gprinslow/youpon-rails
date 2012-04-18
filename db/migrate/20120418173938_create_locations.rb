class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :merchant_id
      t.string :type
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
