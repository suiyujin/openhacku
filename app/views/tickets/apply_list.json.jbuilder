json.apply_list do
  json.array!(@ticket_candidates) do |ticket_candidate|
    json.extract! ticket_candidate, :id, :comment, :ticket_id
    json.created_at ticket_candidate.created_at.strftime("%Y.%m.%d %H:%M:%S")
    json.user do
      json.id ticket_candidate.user.id
      json.last_name ticket_candidate.user.last_name
      json.first_name ticket_candidate.user.first_name
      json.profile_img_url ticket_candidate.user.profile_img_url
    end
  end
end
