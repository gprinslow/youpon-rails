class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.integer :employee_id
      t.string :type

      t.timestamps
    end
  end
end
