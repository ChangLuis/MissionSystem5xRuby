FactoryBot.define do
  factory :mission1, class: "Mission" do
    user_id { 1 }
    title { "Date" }
    contents { "Dating with 5xRuby" }
    status { "finish" }
    priority_order { "nomal_priority" }
    initial_time_at { "2020-01-23 08:00".to_datetime }
    finish_time_at { "2020-01-31 22:00".to_datetime }
  end

  factory :mission2, class: "Mission" do
    user_id { 2 }
    title { "Meeting" }
    contents { "Meeting with 5xRuby" }
    status { "pending" }
    priority_order { "high_priority" }
    initial_time_at { "2020-01-25 17:00".to_datetime }
    finish_time_at { "2020-01-25 22:00".to_datetime }
  end
end
