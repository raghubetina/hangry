class WaitTime < ActiveRecord::Base
  validates :restaurant, :presence => true
  validates :party_size, :presence => true
  validates :minutes, :presence => true
  validates :checked_at, :presence => true

  belongs_to :restaurant
end
