json.tickets do
  json.array! @tickets, partial: 'tickets/ticket', as: :ticket
end
