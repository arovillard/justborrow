class User < ActiveRecord::Base

  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :products, foreign_key: "lender_id"
  has_many :rentals
  # has_many :borrowed_products, through: :rentals, source: :user

end
