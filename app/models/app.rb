class App

  def call(env)
    # define a response and a request
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # first route
    # TESTING Route => localhost:9393/test

    # Our routing will exist as a large condtional
    if req.path == "/test"
      # array of our status code, content-type, response to the user
      return [ 
        200, # status code
        {'Content-Type' => 'application/json'}, #content-type
        [
          {message: "test response!"}.to_json # actual content
        ]
      ]

    # * Owners Routes
    elsif req.path.match(/owners/)
      if req.env["REQUEST_METHOD"] == "GET"
        if req.path.split("/owners").length == 0 
          # /owners => index GET all owners
          owners = Owner.all
          return [ 
            200, {'Content-Type' => 'application/json'}, 
            [
              owners.to_json 
            ]
          ]       
        else
          # /owners/:id => show GET display owner of id
          owner_id = req.path.split("/owners/")[1].to_i
          found_owner = Owner.find_by(id: owner_id)
          return [ 
            200, {'Content-Type' => 'application/json'}, 
            [
              found_owner.to_json 
            ]
          ] 
        end
      elsif req.env["REQUEST_METHOD"] == "POST"
        # /owners => POST to add a new owner 

        # res => res.json() 
        # parse our json from a stringified version
        form_data = JSON.parse(req.body.read)

        # use the form_data to create a new instance of the owner class, then return the newly created instance
        new_owner = Owner.create(name: form_data["name"])
        return [ 
          200, {'Content-Type' => 'application/json'}, 
          [
            new_owner.to_json 
          ]
        ] 
      end


    else
      # the else is if they go to a route that we did not create
      return [ 
        400, {'Content-Type' => 'application/json'}, 
        [
          {error: "Path Not Found"}.to_json 
        ]
      ]       
    end

    resp.finish
  end

end