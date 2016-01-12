require 'pry'

RSpec.describe OrderItem, type: :model do
  describe "model validations" do
      it "must have a quantity, order_id, and product_id" do
        test_orderitem = OrderItem.new()
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
        expect(test_orderitem.errors.keys).to include :order_id
        expect(test_orderitem.errors.keys).to include :product_id
      end
      it "can't have a quantity that isn't an integer" do
        test_orderitem = OrderItem.new({ quantity: "hi" })
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
      end
      it "can't have a quantity equal to 0" do
        test_orderitem = OrderItem.new({ quantity: 0 })
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
      end
      it "can't have a quantity less than 0" do
        test_orderitem = OrderItem.new({ quantity: -1 })
        expect(test_orderitem).to_not be_valid
        expect(test_orderitem.errors.keys).to include :quantity
      end
      it "belongs to an order and product" do
        create(:order)
        create(:product)
        test_orderitem = OrderItem.create({ quantity: 3, order_id: 1, product_id: 1 })
        expect(test_orderitem.order.id).to eq 1
        expect(test_orderitem.product.id).to eq 1
      end
    end
end
