class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]
    elsif req.path=="/people"
      return [201, { 'Content-Type' => 'application/json' }, [Person.all.to_json]]
    # elsif req.path=="/rounds"
    #   return [201, { 'Content-Type' => 'application/json' }, [Round.all.to_json]]
    elsif req.path.match(/rounds/) && req.post?
    
      hash = JSON.parse(req.body.read)
      newArr = hash.delete("people_drinking")
      newRound = Round.create(hash)
      newArr.each{|el| PersonRound.create(round_id: newRound.id,person_id: el.to_i)}
      PersonRound.create(round_id:newRound.id, person_id:hash["person_id"].to_i)
      newRound.balance_splitter
      return [201, { 'Content-Type' => 'application/json' }, [newRound.to_json]]

    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
