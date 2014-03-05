class Rental < ActiveRecord::Base

  belongs_to :borrower, class_name: "User" #lender
  belongs_to :product

end
