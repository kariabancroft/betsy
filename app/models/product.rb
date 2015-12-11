class Product < ActiveRecord::Base
  belongs_to :merchant
  has_many :reviews
  has_many :orderitems
  has_and_belongs_to_many :categories

  validates_associated :reviews
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_decimal: true, greater_than: 0 }
  
end
