json.extract! review, :id, :score, :comment
json.created_at review.created_at.strftime("%Y.%m.%d %H:%M:%S")
json.from_user do
  json.id review.from_user.id
  json.username review.from_user.username
  json.profile_img_url review.from_user.profile_img_url
end
json.to_user do
  json.id review.to_user.id
  json.username review.to_user.username
  json.profile_img_url review.to_user.profile_img_url
end
