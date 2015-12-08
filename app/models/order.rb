class Order < ActiveRecord::Base
  has_many :order_items

  validates_presence_of :name, :bill_zip, :cc_exp, :cc_num, :city, :email, :sec_code, :state, :street, :zip
end
