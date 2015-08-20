class AddPackageIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :package_id, :integer
    add_index :order_items, :package_id
  end
end
