json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :title, :body, :time, :price, :place, :bought, :user_id, :bought_user_id
  json.url ticket_url(ticket, format: :json)
end
