# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
seed_categories = [
  {name: "Animals", photo_url: "http://www.sfltimes.com/wp-content/uploads/2015/07/Green-Sea-Turtle.jpg"},
  {name: "Plants", photo_url: "http://b.fastcompany.net/multisite_files/coexist/poster/2013/07/1682596-poster-1280-seaweed.jpg"},
  {name: "Seashells", photo_url: "http://miriadna.com/desctopwalls/images/max/Seashell-on-the-sand.jpg"},
  {name: "Clothing", photo_url: "http://www.animalshirts.net/dolphinshirts/10-3081.jpg"}
]

seed_categories.each do |cat|
  Category.create cat
end

seed_merchants = [
  {username: "kdefliese", email: "kdefliese@gmail.com", password: "cats", password_confirmation: "cats"},
  {username: "seabay", email: "seabay@seabay.com", password: "seabay", password_confirmation: "seabay"}
]

seed_merchants.each do |mer|
  Merchant.create mer
end

seed_products = [
  {name: "Sea Anemone", price: 500, photo_url: "http://www.cabrillomarineaquarium.org/_photos/species-green-sea-anemone.jpg", description: "Is it fluffy, or slimy?", quantity: 5, merchant_id: 1},
  {name: "Starfish", price: 500, photo_url: "http://www.buckeyescuba.com/wp-content/uploads/2012/04/starfish2.jpg", description: "", quantity: 5, merchant_id: 2}
]

seed_products.each do |pro|
  Product.create pro
end

Product.find(1).categories << Category.find(2)
Product.find(2).categories << Category.find(1)

seed_orders = [
  {purchase_time: Time.now, name: "Ricky", email: "ricky@awesome.com", street: "Ada Street", city: "Seattle", state: "WA", zip: 98112, cc_num: "1234", cc_exp: Time.now.to_date, sec_code: 123, bill_zip: 98112}
]

seed_orders.each do |ord|
  Order.create ord
end

seed_order_items = [
  {quantity: 1, order_id: 1, product_id: 1},
  {quantity: 1, order_id: 1, product_id: 2}
]

seed_order_items.each do |oi|
  OrderItem.create oi
end

seed_reviews = [
  {rating: 5, description: "Amazing", product_id: 1},
  {rating: 3, description: "Mediocre", product_id: 2},
  {rating: 1, description: "Super Lame", product_id: 1}
]

seed_reviews.each do |r|
  Review.create r
end
