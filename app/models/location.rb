class Location < ActiveRecord::Base
   has_many :books
	has_one :user
end
