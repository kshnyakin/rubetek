json.extract! user, :id, :email, :is_admin, :name, :created_at, :updated_at
json.url user_url(user, format: :json)
