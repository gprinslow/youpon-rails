class AddAttributestoMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :phone, :string
    add_column :merchants, :website, :string
  end
end
