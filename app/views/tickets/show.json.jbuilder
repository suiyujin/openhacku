json.extract! @ticket, :id, :title, :body, :time, :price, :place
json.user do
  json.name @ticket.user.name
end
