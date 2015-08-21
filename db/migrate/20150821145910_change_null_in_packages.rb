class ChangeNullInPackages < ActiveRecord::Migration
  def change
    change_column_null :packages, :cost, true
    change_column_null :packages, :service, true
  end
end
