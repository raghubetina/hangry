class Restaurant < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :scope => :address }
  validates :address, :presence => true
  validates :phone_number, :presence => true
  validates :opens_at, :presence => true
  validates :closes_at, :presence => true

  has_many :wait_times
end
