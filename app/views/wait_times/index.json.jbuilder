json.array!(@wait_times) do |wait_time|
  json.extract! wait_time, :id, :restaurant_id, :party_size, :minutes, :checked_at
  json.url wait_time_url(wait_time, format: :json)
end
