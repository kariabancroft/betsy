require 'rails_helper'

RSpec.describe Order, type: :model do
  describe ".validates" do
    let(:bad_order){Order.new}

    required_fields = [:name, :bill_zip, :cc_exp, :cc_num, :city, :email, :sec_code, :state, :street, :zip]

    required_fields.each do |field|
      it "must have #{field}" do
          expect(bad_order).to_not be_valid
          expect(bad_order.errors.keys).to include(field)
        end
    end
  end
end
