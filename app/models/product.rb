class Product < ActiveRecord::Base
before_filter :ensure_logged_in, :only => [:edit, :destroy, :new]
  belongs_to :lender, class_name: "User" #lender
  has_many :rentals
  #belongs_to :category


  #Create new model Categories
  # Class Category < ActiveRecord::base
    # has_many :products
end
