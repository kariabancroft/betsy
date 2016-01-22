class AddShippingToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_type, :string
    add_column :orders, :shipping_cost, :integer
  end
end
