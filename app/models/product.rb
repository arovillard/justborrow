class Product < ActiveRecord::Base
  acts_as_taggable
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  mount_uploader :image, ImageUploader
  belongs_to :lender, class_name: "User" #lender
  belongs_to :category
  has_many :rentals
  has_many :product_images
  accepts_nested_attributes_for :product_images

  #belongs_to :category


  #Create new model Categories
  # Class Category < ActiveRecord::base
    # has_many :products
end
