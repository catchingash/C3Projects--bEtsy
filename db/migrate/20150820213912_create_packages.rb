class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.float :weight, scale: 3
      t.float :length, scale: 3
      t.float :width, scale: 3
      t.float :height, scale: 3
      t.float :cost, null: false
      t.string :service, null: false
      t.integer :user_id
      t.integer :buyer_id

      t.timestamps null: false
    end

    add_index :packages, :user_id
    add_index :packages, :buyer_id
  end
end
