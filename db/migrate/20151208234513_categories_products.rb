class CategoriesProducts < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.references :category
      t.references :product
    end

    add_index(:categories_products, [:category_id, :product_id])
  end
end
