json.tickets do
  json.array! @tickets do |ticket|
    json.extract! ticket, :id, :title, :body, :time, :price, :skype, :hangouts, :offline_place, :beginner
    json.stocked_num ticket.stock_tickets.count
    json.applied_num ticket.ticket_candidates.count
    json.read_flag ticket.matching_tickets.select(:read_flag).find_by(user_id: params[:user_id]).read_flag
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
  end
end
