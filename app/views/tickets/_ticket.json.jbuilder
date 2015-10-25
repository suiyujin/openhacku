json.extract! ticket, :id, :title, :body, :time, :price, :place, :sex, :review_min
json.levels ticket.ticket_levels.map(&:level)
json.created_at ticket.created_at.strftime("%Y.%m.%d %H:%M:%S")
json.updated_at ticket.updated_at.strftime("%Y.%m.%d %H:%M:%S")
json.user do
  json.id ticket.user.id
  json.name ticket.user.name
  json.profile_img_url ticket.user.profile_img_url
end
json.keywords do
  json.array!(ticket.keywords) do |keyword|
    json.id keyword.id
    json.name keyword.name
  end
end
