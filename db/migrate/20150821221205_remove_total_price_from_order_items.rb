class RemoveTotalPriceFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :total_price, :float
  end
end
