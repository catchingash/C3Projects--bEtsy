class AddPackageColumnsToProductsTable < ActiveRecord::Migration
  def change
    add_column :products, :dimensions, :string
    add_column :products, :weight, :float
  end
end
