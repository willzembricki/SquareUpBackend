class Purchaser < ActiveRecord::Base 
belongs_to :person
belongs_to :round
end