class ChangeMeasurementsColumnTypesToFloat < ActiveRecord::Migration
  def up
    change_column :products, :length, :float, scale: 3
    change_column :products, :width, :float, scale: 3
    change_column :products, :height, :float, scale: 3
    change_column :products, :weight, :float, scale: 3
  end

  def down
    change_column :products, :length, :string
    change_column :products, :width, :string
    change_column :products, :height, :string
    change_column :products, :weight, :string
  end
end
