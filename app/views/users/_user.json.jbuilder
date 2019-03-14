json.extract! user, :id, :fullname, :email, :password, :mobile, :address, :created_at, :updated_at
json.url user_url(user, format: :json)
