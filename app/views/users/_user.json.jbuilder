json.extract! user, :id, :email, :username, :last_name, :first_name, :sex, :introduction
json.tags do
  json.array!(user.keywords) do |keyword|
    json.id keyword.id
    json.name keyword.name
  end
end
