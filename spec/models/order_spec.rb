require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "model validations" do
    let(:bad_order){Order.new}

    required_fields = [:name, :bill_zip, :cc_exp, :cc_num, :city, :email, :sec_code, :state, :street, :zip]

    required_fields.each do |field|
      it "must have #{field}" do
          expect(bad_order).to_not be_valid
          expect(bad_order.errors.keys).to include(field)
      end
    end
  end

  describe "#total_cost" do
    it "returns total cost of an order" do
      build(:product)
      order = build(:order)
      order_item = build(:order_item)
      order.order_items << order_item
      expect(order.total_cost).to eq 5.00
    end
  end
end
