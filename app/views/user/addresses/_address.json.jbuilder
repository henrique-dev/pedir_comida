json.extract! address, :id, :description, :street, :number, :neighborhood, :city, :state, :country, :zipcode, :latitude, :longitude, :default
json.url user_addresses_url(address, format: :json)
