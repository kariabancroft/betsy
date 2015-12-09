class Order < ActiveRecord::Base
  has_many :order_items

  validates_presence_of :name, :bill_zip, :cc_exp, :cc_num, :city, :email, :sec_code, :state, :street, :zip
  validates :cc_num, length: { is: 16 }
  validates :city, length: { max: 30 }
  validates :status, inclusion: { in: %w(Pending Paid Complete Cancelled) }
end
