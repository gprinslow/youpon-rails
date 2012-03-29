class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :merchant_id
      t.string :type
      t.string :title
      t.string :byline
      t.string :category
      t.string :discount
      t.string :description
      t.string :terms
      t.datetime :start
      t.datetime :end
      t.integer :number_offered
      t.boolean :validation_required

      t.timestamps
    end
  end
end
