require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:empty_product) do
    Product.new
  end

  let(:good_product) do
  Product.create({
      name: "Dolphin",
      price: 2,
      photo_url: "www.dolphin.com",
      description: "description"
    })
  end

  describe "model validations" do
    it "requires that a product name be present" do
      expect(empty_product).to be_invalid
      expect(empty_product.errors.keys).to include :name
    end

    it "requires that a product have a unique name" do
      good_product
      dup_product = good_product.dup
      dup_product.save
      expect(dup_product).to_not be_valid
      expect(dup_product.errors[:name]).to include("has already been taken")
    end

    it "requires that the price is present" do
      expect(empty_product).to be_invalid
      expect(empty_product.errors.keys).to include (:price)
    end

    it "expects price to be an integer" do
      bad_price = Product.create(price: "notaprice")
      expect(bad_price).to be_invalid
    end
  end
end

  # belongs_to :merchant
  # has_many :reviews
  # has_many :orderitems
  # has_and_belongs_to_many :categories
  #
  # validates_associated :reviews
  # validates_associated :orderitems
  # validates :name, presence: true, uniqueness: true
  # validates :price, presence: true, numericality: true, greater_than: 0
  #
