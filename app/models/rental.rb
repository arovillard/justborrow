class Rental < ActiveRecord::Base
  belongs_to :borrower, class_name: "User"
  belongs_to :product
  has_many :messages

end
