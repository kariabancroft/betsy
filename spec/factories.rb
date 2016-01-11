FactoryGirl.define do
  # factory :asdfklajds, class: Product do
  factory :factory_product, class: Product do
    name "Sea Anemone"
    price 5.00
    photo_url "http://www.cabrillomarineaquarium.org/_photos/species-green-sea-anemone.jpg"
    description "Is it fluffy, or slimy?"
    quantity 5
    merchant_id 1
  end

  factory :order do
    purchase_time Time.now
    name "Ricky"
    email "ricky@awesome.com"
    street "Ada Street"
    city "Seattle"
    state "WA"
    zip 98112
    cc_num "1234"
    cc_exp Time.now.to_date
    sec_code 123
    bill_zip 98112
    status "Paid"
  end

  factory :order_item do
    quantity 1
    association :order
    association :product, factory: :factory_product
  end
end
