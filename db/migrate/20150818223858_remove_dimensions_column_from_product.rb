class RemoveDimensionsColumnFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :dimensions, :string
  end
end
