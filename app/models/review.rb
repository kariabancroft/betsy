class Review < ActiveRecord::Base
  belongs_to :product
  validates :rating, presence: true
  validates_numericality_of :rating, :only_integer => true, :less_than_or_equal_to => 5
end
