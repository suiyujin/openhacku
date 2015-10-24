json.tickets do
  json.array!(@tickets) do |ticket|
    json.extract! ticket, :id, :title, :body, :time, :price, :place, :sex, :review_min, :level
    json.user do
      json.id ticket.user.id
      json.name ticket.user.name
      json.profile_img_url ticket.user.profile_img_url
    end
  end
end
