require 'faker'


puts "Destroying All Venues"
Venue.destroy_all


(1..40).each do
    Venue.create!(
      name: Faker::Restaurant.name,
      is_activate: [ true, false ].sample,
    )
end