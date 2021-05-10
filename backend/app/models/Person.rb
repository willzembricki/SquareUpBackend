class Person < ActiveRecord::Base 
has_many :purchasers
has_many :rounds, through: :purchasers
end