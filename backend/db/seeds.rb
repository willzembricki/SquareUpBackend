Person.destroy_all
Round.destroy_all
PersonRound.destroy_all 

4.times do 
  Person.create(name: Faker::Name.name,balance: 0, total: 0  )
end


# PersonRound.create(round_id:1,person_id:1 )
# PersonRound.create(round_id:1,person_id:2 )
# PersonRound.create(round_id:1,person_id:3 )

# PersonRound.create(round_id:2,person_id:1 )
# PersonRound.create(round_id:2,person_id:4 )

