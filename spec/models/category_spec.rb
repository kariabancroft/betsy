require 'rails_helper'

RSpec.describe Category, type: :model do
  describe ".validates" do
    it "must have a name" do
      expect(build(:category)).to be_valid
      expect(build(:category, name: nil)).to be_invalid
    end
  end
end
