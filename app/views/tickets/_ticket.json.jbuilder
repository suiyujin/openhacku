json.extract! ticket, :id, :title, :body, :time, :price, :skype, :hangouts, :offline_place, :beginner, :bought_user_id, :header_img_url, :ticket_img_url
json.stocked_num ticket.stock_tickets.count
json.applied_num ticket.ticket_candidates.count
json.created_at ticket.created_at.strftime("%Y.%m.%d %H:%M:%S")
json.updated_at ticket.updated_at.strftime("%Y.%m.%d %H:%M:%S")
json.user do
  json.id ticket.user.id
  json.username ticket.user.username
  json.review_ave ticket.user.review_ave
  json.profile_img_url ticket.user.profile_img_url
  json.header_img_url ticket.user.header_img_url
end
json.tags do
  json.array!(ticket.keywords) do |keyword|
    json.id keyword.id
    json.name keyword.name
  end
end
