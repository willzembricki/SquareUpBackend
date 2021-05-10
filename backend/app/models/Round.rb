class Round < ActiveRecord::Base 
    has_many :purchasers
    has_many :persons, through: :purchasers
    has_many :rounddrinks
    has_many :drinks, through: :rounddrinks
end