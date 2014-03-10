class Product < ActiveRecord::Base
  acts_as_taggable
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  geocoded_by :ip_address
  mount_uploader :image, ImageUploader
  belongs_to :lender, class_name: "User" #lender
  belongs_to :category
  has_many :rentals
  has_many :product_images
  accepts_nested_attributes_for :product_images

  def self.search(search)
    search_array=[]
    searchwords = search.split
    searchwords.each do |word|
     search_array += find(:all, :conditions => ["title like ? OR description like ? OR address like ?", "%#{word}%", "%#{word}%", "%#{word}%"])
    end
    search_array.uniq
  end

end


