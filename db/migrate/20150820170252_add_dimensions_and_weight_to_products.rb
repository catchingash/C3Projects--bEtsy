class AddDimensionsAndWeightToProducts < ActiveRecord::Migration
  def change
    add_column :products, :length, :string
    add_column :products, :width, :string
    add_column :products, :height, :string
    add_column :products, :weight, :string
  end
end
