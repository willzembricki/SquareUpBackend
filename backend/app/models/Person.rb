
class Person < ActiveRecord::Base 
    has_many :rounds_i_bought, class_name: "Round", foreign_key: :person_id
    has_many :person_rounds
    has_many :rounds, through: :person_rounds
    

end
