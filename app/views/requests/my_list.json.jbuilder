json.array!(@requests) do |request|
  json.extract! request, :id, :title, :body, :user_id
  json.url request_url(request, format: :json)
end
