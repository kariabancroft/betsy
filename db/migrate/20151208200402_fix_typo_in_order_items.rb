class FixTypoInOrderItems < ActiveRecord::Migration
  def change
    rename_column :orderitem, :quanitity, :quantity
  end
end
