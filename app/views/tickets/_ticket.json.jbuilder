json.extract! ticket, :id, :title, :body, :time, :price, :place, :beginner
json.stock_num ticket.stock_tickets.count
json.created_at ticket.created_at.strftime("%Y.%m.%d %H:%M:%S")
json.updated_at ticket.updated_at.strftime("%Y.%m.%d %H:%M:%S")
json.user do
  json.id ticket.user.id
  json.username ticket.user.username
  json.profile_img_url ticket.user.profile_img_url
  json.header_img_url ticket.user.header_img_url
end
json.tags do
  json.array!(ticket.keywords) do |keyword|
    json.id keyword.id
    json.name keyword.name
  end
end
