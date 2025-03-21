require 'faker'

puts "Cleaning up the database..."
puts "Destroying All Reviews and Ratings"
Rating.destroy_all
Review.destroy_all

puts "Destroying All Venue-VenueType Associations"
VenueVenueType.destroy_all

puts "Destroying All Venues"
Venue.destroy_all

puts "Destroying All Venue Types"
VenueType.destroy_all

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

puts "Creating Venue Types"
venue_types = [
  { name: "Restaurant", description: "Food service establishment" },
  { name: "Café", description: "Coffee and light meals" },
  { name: "Bar", description: "Drinks and entertainment" },
  { name: "Breakfast", description: "Morning meals" },
  { name: "Fast Food", description: "Quick service dining" },
  { name: "Vegan-friendly", description: "Options for vegans" },
  { name: "Gluten-free", description: "Gluten-free options" },
  { name: "Outdoor Seating", description: "Patio or outdoor space" },
  { name: "Delivery", description: "Offers food delivery" },
  { name: "Late Night", description: "Open late" },
  { name: "Family-friendly", description: "Great for families with kids" },
  { name: "Live Music", description: "Features live music performances" },
  { name: "Wine Bar", description: "Extensive wine selection" },
  { name: "Sports Bar", description: "Watch sports events" },
  { name: "Fine Dining", description: "Upscale dining experience" }
]

venue_types.each do |attrs|
  VenueType.find_or_create_by(name: attrs[:name]) do |vt|
    vt.description = attrs[:description]
  end
end

puts "Created #{VenueType.count} Venue Types"

puts "Creating Venues with Types"
def assign_random_types(venue)
  all_types = VenueType.all.to_a

  main_type_count = rand(1..3)

  side_type_count = rand(0..5)

  shuffled_types = all_types.shuffle

  main_types = shuffled_types.take(main_type_count)
  main_types.each_with_index do |type, index|
    venue.add_main_type(type, index + 1)
  end

  remaining_types = shuffled_types - main_types

  side_types = remaining_types.take(side_type_count)
  side_types.each do |type|
    venue.add_side_type(type)
  end
end

owners = User.where(role: :owner).to_a
venue_count = 150

venue_count.times do |i|
  venue = Venue.create!(
    name: Faker::Restaurant.name,
    is_activate: [ true, false ].sample,
    address: Faker::Address.street_address,
    city: "Warszawa",
    postal_code: "01-910",
    latitude: rand(52.18..52.31),
    longitude: rand(20.87..21.08),
    user_id: owners.sample.id
  )

  assign_random_types(venue)
end

puts "\nCreated #{Venue.count} Venues"



reviews = []
reviewers = User.where(role: :reviewer).to_a
venues = Venue.all.to_a
review_count = 150

review_count.times do
  reviews << {
    content: Faker::Restaurant.review,
    venue_id: venues.sample.id,
    user_id: reviewers.sample.id
  }
end

reviews.each do |review_data|
  review = Review.create!(review_data)
  Rating.create!(
    review: review,
    atmosphere_rating: rand(1..6),
    availability_rating: rand(1..6),
    quality_rating: rand(1..6),
    service_rating: rand(1..6),
    uniqueness_rating: rand(1..6),
    value_rating: rand(1..6)
  )
end
puts "Created #{Review.count} Reviews with Ratings"

Venue.find_each(&:update_avg_rating)
puts "Updated all venue average ratings"
puts "Seed completed successfully!"
