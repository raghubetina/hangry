json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :address, :phone_number, :yelp_url, :opens_at, :closes_at
  json.url restaurant_url(restaurant, format: :json)
end
