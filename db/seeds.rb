# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Mission.all.count.zero?
  500.times do
    Mission.create(
      user_id: Faker::Number.within(range: 1..10),
      title: Faker::Name.initials(number: 5),
      contents: Faker::Job.field,
      status: %w[pending processing finish].sample,
      priority_order: %w[low_priority nomal_priority high_priority].sample,
      initial_time_at: Faker::Time.between_dates(from: Time.zone.today - 1, to: Time.zone.today),
      finish_time_at: Faker::Time.between_dates(from: Time.zone.today + 1, to: Time.zone.today + [*2..10].sample)
    )
  end
end

User.create(account: "changluis", name: "ChangLuis", password: "20190508")
User.create(account: "admin", name: "Adminstrator", password: "20190508", is_admin: true)
