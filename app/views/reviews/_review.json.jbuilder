json.extract! review, :id, :score, :comment
json.from_user do
  json.id review.from_user.id
  json.username review.from_user.username
end
json.to_user do
  json.id review.to_user.id
  json.username review.to_user.username
end
