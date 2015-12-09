require 'rails_helper'

RSpec.describe Review, type: :model do

  describe "model validations" do
    it "requires a value" do
      empty_item = Review.new
      expect(empty_item).to be_invalid
      expect(empty_item.errors.keys).to include :rating
    end
  end
  # does not work - fix!
  describe "model validations for integer input" do
    let(:bad_params) do
        {
          review: {
            review_id: 1,
            rating: 6,
            description: "A good product"
          }
        }
      end

    it "requires an integer between 1-5" do
        expect(bad_params).to be_invalid
        expect(bad_params.errors.keys).to include :rating
    end
  end

end
