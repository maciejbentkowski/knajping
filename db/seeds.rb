require 'faker'


puts "Destroying All Venues"
Venue.destroy_all


puts "Destroying All Users"
User.destroy_all



puts "Creating Users"
sample_users = [
  { email: "user@sample.com", password: "password", username: Faker::Name.name },
  { email: "user2@sample.com", password: "password", username: Faker::Name.name },
  { email: "user3@sample.com", password: "password", username: Faker::Name.name },
  { email: "owner@sample.com", password: "password", username: Faker::Name.name, role: :owner },
  { email: "owner2@sample.com", password: "password", username: Faker::Name.name, role: :owner },
  { email: "owner3@sample.com", password: "password", username: Faker::Name.name, role: :owner },
  { email: "moderator@sample.com", password: "password", username: Faker::Name.name, role: :moderator },
  { email: "admin@sample.com", password: "password", username: "Admin", role: :admin }
]

User.create!(sample_users)
puts "Created #{User.admin.all.count} Admin, #{User.moderator.all.count} Moderator, #{User.owner.all.count} Owners, and #{User.reviewer.all.count} Plain Users"

(1..60).each do
    Venue.create!(
      name: Faker::Restaurant.name,
      is_activate: [ true, false ].sample,
      user_id: User.where(role: :owner).sample.id
    )
end

puts "Created #{Venue.all.count} Venues"
