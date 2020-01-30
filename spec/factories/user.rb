FactoryBot.define do
  factory :user, class: "User" do
    account { "changluis" }
    name { "ChangLuis" }
    password { "20190508" }
    is_admin { false }
  end
end
