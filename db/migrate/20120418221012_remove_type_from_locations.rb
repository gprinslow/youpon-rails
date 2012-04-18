class RemoveTypeFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :type
  end

  def down
    add_column :locations, :type, :string
  end
end
