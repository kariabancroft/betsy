require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "model validations" do
    it "requires a value" do
      review = Review.new
      expect(review).to be_invalid
      expect(review.errors.keys).to include :rating
    end
    # it "requires an integer between 1-5" do
    #   review=Review.new(ranking:6)

    # end
  end

end
#
# validates_numericality_of :rating, :only_integer => true, :presence => true
# :less_than_or_equal_to => 5
