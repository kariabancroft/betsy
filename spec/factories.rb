FactoryGirl.define do
  factory :product do
    name "Sea Anemonie"
    price 5
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
    city "Seatte"
    state "WA"
    zip 98112
    cc_num "1234"
    cc_exp Time.now.to_date
    sec_code 123
    bill_zip 98112
    status "Pending"
  end

  factory :order_item do
    quantity 1
    order
    product
  end

  factory :category do
    name "name"
  end

  factory :merchant do
    username "merchant"
    email "sdfs@sdf.com"
    password "123"
    password_confirmation "123"
  end

end
