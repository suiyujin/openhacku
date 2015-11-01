json.extract! user, :id, :email, :username, :last_name, :first_name, :sex, :introduction, :profile_img_url, :header_img_url
json.review_ave @review_ave
json.teached_num @teached_num
json.learned_num @learned_num
json.stock_num @stock_num
json.tags do
  json.array!(user.keywords) do |keyword|
    json.id keyword.id
    json.name keyword.name
  end
end
