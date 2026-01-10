FactoryBot.define do
  factory :task do
    title { "Buy Groceries" }
    description { "Need milk and eggs" }
    status { "pending" }
    priority { 1 }
    due_date { DateTime.now + 1.day }
    
    # This automatically creates a User and links it to the Task
    association :user 
  end
end