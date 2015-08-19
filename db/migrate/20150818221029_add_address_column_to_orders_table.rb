class AddAddressColumnToOrdersTable < ActiveRecord::Migration
  def change
    add_column :orders, :buyer_street, :string
    add_column :orders, :buyer_city, :string
    add_column :orders, :buyer_state, :string
    add_column :orders, :buyer_country, :string, default: "US"
    add_column :orders, :buyer_zip, :string
  end
end
