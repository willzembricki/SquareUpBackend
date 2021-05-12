require 'pry'
class Round < ActiveRecord::Base 
    belongs_to :person
    has_many :person_rounds
    has_many :people, through: :person_rounds 
    
 
    def balance_splitter
        
        self.person.update(:total => self.person.total + self.price) 
       
        split_price= (self.price)/PersonRound.all.select{|pr| pr.round_id == self.id}.count 
        person_insts = PersonRound.all.select{|pr| pr.round_id == self.id}.map{|person| Person.find(person.person_id)}
        person_insts.each do |person| 
          if person.id == self.person_id
            person.update(:balance => (person.balance - split_price)+ self.price)
          else   
            person.update(:balance => (person.balance - split_price))
          end  
       end
    end
    def deletedRound
      
      self.person.update(:total => self.person.total - self.price) 
       
      split_price= (self.price)/PersonRound.all.select{|pr| pr.round_id == self.id}.count 
      person_insts = PersonRound.all.select{|pr| pr.round_id == self.id}.map{|person| Person.find(person.person_id)}
      person_insts.each do |person| 
        if person.id == self.person_id
          person.update(:balance => (person.balance + split_price) - self.price)
        else   
          person.update(:balance => (person.balance + split_price))
        end  
     end
    
    end  
end