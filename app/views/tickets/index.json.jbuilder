json.tickets do |json|
  json.array!(@tickets) do |ticket|
    json.extract! ticket, :id, :title, :body, :time, :price, :place, :sex, :review_min, :level
    json.user do
      json.name ticket.user.name
    end
  end
end
