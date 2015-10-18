json.array!(@requests) do |request|
  json.extract! request, :id, :title, :body
  json.url request_url(request, format: :json)
end
