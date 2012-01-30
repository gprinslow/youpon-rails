class AddCodeToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :code, :string
  end
end
