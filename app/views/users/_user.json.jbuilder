json.extract! user, :id, :email, :username, :last_name, :first_name, :sex, :introduction, :profile_img_url, :header_img_url
json.review_ave @review_ave
json.tags do
  json.array!(user.keywords) do |keyword|
    json.id keyword.id
    json.name keyword.name
  end
end
