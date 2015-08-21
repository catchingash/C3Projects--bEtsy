class RemoveSubtotalFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :subtotal, :float
  end
end
