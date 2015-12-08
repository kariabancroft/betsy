require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "model validations" do
      it "must have a username" do
        test_merchant = Merchant.new()
        expect(test_merchant).to_not be_valid
        expect(test_merchant.errors.keys).to include :username
      end
      it "must have an email" do
        test_merchant = Merchant.new()
        expect(test_merchant).to_not be_valid
        expect(test_merchant.errors.keys).to include :email
      end
      it "must have a unique username" do
        Merchant.create({ username: "merchant", email: "sdfs@sdf.com" })
        test_merchant2 = Merchant.new({ username: "merchant", email: "gdfs@sdf.com" })
        expect(test_merchant2.save).to eq false
        expect(test_merchant2.errors.keys).to include :username
      end
      it "must have a unique email" do
        Merchant.create({ username: "merchant1", email: "sdfs@sdf.com" })
        test_merchant2 = Merchant.new({ username: "merchant2", email: "sdfs@sdf.com" })
        expect(test_merchant2.save).to eq false
        expect(test_merchant2.errors.keys).to include :email
      end
    end
end
