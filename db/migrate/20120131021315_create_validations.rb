class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.integer :request_id
      t.integer :employee_id
      t.integer :status_id
      t.string :type
      t.string :criteria
      t.string :match

      t.timestamps
    end
  end
end
