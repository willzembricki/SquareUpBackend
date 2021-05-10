class Drink < ActiveRecord::Base 
    has_many :rounddrinks
    has_many :rounds, through: :rounddrinks
end