class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :type
      t.string :text

      t.timestamps
    end
  end
end
