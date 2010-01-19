class Area < ActiveRecord::Base
  has_many :users, :through => :colaborations
end
