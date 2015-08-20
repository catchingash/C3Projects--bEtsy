class AddCountryToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :country, :string, null: false, default: "US"
  end
end
