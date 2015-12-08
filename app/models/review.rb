class Review < ActiveRecord::Base
  belongs_to product
  # rating - integer, must be present, must be an integer, must be between 1 and 5
  
end
