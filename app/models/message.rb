class Message < ActiveRecord::Base
  belongs_to :rental
  belongs_to :user
end
