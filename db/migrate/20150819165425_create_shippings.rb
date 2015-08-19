class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :carrier
      t.integer :price
      t.datetime :est_date
      t.string :service_name
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
