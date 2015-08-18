class RemoveExtraAddressColumnFromOrdersTable < ActiveRecord::Migration
  def change
    remove_column :orders, :buyer_address, :text
  end
end
