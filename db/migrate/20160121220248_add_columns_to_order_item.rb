class AddColumnsToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :shipping_type, :string
    add_column :order_items, :shipping_cost, :integer
  end
end
