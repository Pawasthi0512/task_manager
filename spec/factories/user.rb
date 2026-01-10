FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "user_#{rand(1000)}@example.com" } # Random email to pass uniqueness
    password { "password123" }
  end
end