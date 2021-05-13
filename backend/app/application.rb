class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]
    elsif req.path.match(/people/) && req.post?
      hash = JSON.parse(req.body.read)
      hash.merge!(balance: 0.00,total: 0.00)
      newPerson = Person.create(hash)
      return [201, { 'Content-Type' => 'application/json' }, [newPerson.to_json]]

    elsif req.path == "/people"
      return [201, { 'Content-Type' => 'application/json' }, [Person.all.to_json]]

     elsif req.path.match("/rounds/") && req.patch?
    
      id = req.path.split("/rounds/").last
      personPaying = Round.find(id).person_id
      deletedR = Round.find(id).destroy
      deletedR.deletedRound
      people_drinking = deletedR.person_rounds.map{|pr| pr.person_id }
      deletedR.person_rounds.destroy_all
      hash = JSON.parse(req.body.read)
      hash.merge!(person_id: personPaying)
      newArr = people_drinking
      newRound = Round.create(hash)
      newArr.each{|el| PersonRound.create(round_id: newRound.id,person_id: el.to_i)}
      # PersonRound.create(round_id:newRound.id, person_id:hash[:person_id].to_i)
      newRound.balance_splitter
      returnArr = [Round.all,PersonRound.all, Person.all]
      return [201, { 'Content-Type' => 'application/json' }, [returnArr.to_json]]

    elsif req.path.match(/rounds/) && req.post?
    
      hash = JSON.parse(req.body.read)
      newArr = hash.delete("people_drinking")
      newRound = Round.create(hash)
      pr_arr = newArr.map{|el| PersonRound.create(round_id: newRound.id,person_id: el.to_i)}
      pr_arr << PersonRound.create(round_id:newRound.id, person_id:hash["person_id"].to_i)
      newRound.balance_splitter
      roundPersonHash = [Round.all,PersonRound.all, Person.all]
      return [201, { 'Content-Type' => 'application/json' }, [roundPersonHash.to_json]]
    elsif req.path.match(/rounds/) && req.delete?
      id = req.path.split("/rounds/").last
      deletedRound = Round.find(id).destroy
      deletedRound.deletedRound
      deletedRound.person_rounds.destroy_all
      updatedAllDataArray = [Round.all,PersonRound.all, Person.all]
      return [201, { 'Content-Type' => 'application/json' }, [updatedAllDataArray.to_json]]
    elsif req.path == "/rounds"
      return [201, { 'Content-Type' => 'application/json' }, [Round.all.to_json]]
    elsif req.path.match("/rounds") && req.get?
      if req.path == "/rounds"
        return [201, { 'Content-Type' => 'application/json' }, [Round.all.to_json]]
      else  
       
        id = req.path.split("/rounds/").last
        return [201, { 'Content-Type' => 'application/json' }, [Round.find(id.to_i).to_json]]
      end
    elsif req.path == "/person_rounds"
      return [201, { 'Content-Type' => 'application/json' }, [PersonRound.all.to_json]]
    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
