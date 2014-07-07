json.array!(@walls) do |wall|
  json.extract! wall, :id, :name, :instagram_hashtag, :description
  json.url wall_url(wall, format: :json)
end
