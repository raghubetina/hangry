class Restaurant < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :scope => :address }
  validates :address, :presence => true
  validates :phone_number, :phony_plausible => true

  phony_normalize :phone_number, :default_country_code => 'US'

  has_many :wait_times
end
