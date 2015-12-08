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
        Merchant.create({ username: "merchant", email: "sdfs@sdf.com", password: "123", password_confirmation: "123" })
        test_merchant2 = Merchant.new({ username: "merchant", email: "gdfs@sdf.com", password: "123", password_confirmation: "123" })
        expect(test_merchant2.save).to eq false
        expect(test_merchant2.errors.keys).to include :username
      end
      it "must have a unique email" do
        Merchant.create({ username: "merchant1", email: "sdfs@sdf.com", password: "123", password_confirmation: "123" })
        test_merchant2 = Merchant.new({ username: "merchant2", email: "sdfs@sdf.com", password: "123", password_confirmation: "123" })
        expect(test_merchant2.save).to eq false
        expect(test_merchant2.errors.keys).to include :email
      end
      it "must have a password confirmation that matches password" do
        test_merchant = Merchant.new({ username: "merchant1", email: "sdfs@sdf.com", password: "123", password_confirmation: "321" })
        expect(test_merchant.save).to eq false
        expect(test_merchant.errors.keys).to include :password_confirmation
      end
    end
end
