require 'faker'

puts "Cleaning up the database..."

puts "Cleaning up Questions and Answers..."
Answer.destroy_all
Question.destroy_all


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
  { name: "Wine Bar", description: "Extensive wine selection" },
  { name: "Fast Food", description: "Quick service dining" },
  { name: "Bakery", description: "Fresh-baked goods and pastries" },
  { name: "Steakhouse", description: "Specializes in premium cuts of beef and meats" },
  { name: "Seafood", description: "Focus on fish and seafood dishes" },
  { name: "Buffet", description: "Self-service with variety of all-you-can-eat options" },
  { name: "Brunch", description: "Late morning to early afternoon dining" },
  { name: "Pizzeria", description: "Specializes in pizza varieties" }
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

  type_count = rand(1..3)

  shuffled_types = all_types.shuffle

  types = shuffled_types.take(type_count)
  types.each_with_index do |type, index|
    venue.add_main_type(type, index + 1)
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


puts "Creating Questions and Answers..."

# Get all venues and users to reference
venues = Venue.where(is_activate: true).to_a
users = User.where(role: [ :reviewer, nil ]).to_a
total_venues = venues.count

# Common questions about venues
question_templates = [
  "Is %{venue_name} wheelchair accessible?",
  "Does %{venue_name} take reservations?",
  "What are the opening hours for %{venue_name}?",
  "Is there parking available at %{venue_name}?",
  "Does %{venue_name} have vegetarian options?",
  "Is %{venue_name} child-friendly?",
  "Does %{venue_name} accept credit cards?",
  "Is there a dress code at %{venue_name}?",
  "Does %{venue_name} have Wi-Fi?",
  "Is %{venue_name} good for large groups?",
  "Does %{venue_name} offer takeout?",
  "Is outdoor seating available at %{venue_name}?",
  "Does %{venue_name} serve alcohol?",
  "Is %{venue_name} good for business meetings?",
  "What's the average price range at %{venue_name}?",
  "Is %{venue_name} noisy or quiet?",
  "Does %{venue_name} have gluten-free options?",
  "Is there live music at %{venue_name}?",
  "How busy does %{venue_name} get on weekends?",
  "Does %{venue_name} allow pets?"
]

# Answer templates for each question type (array of possible answers)
answer_templates = {
  "wheelchair" => [
    "Yes, %{venue_name} is fully wheelchair accessible with ramps and accessible bathrooms.",
    "Unfortunately, %{venue_name} has steps at the entrance and no elevator.",
    "Partially. The main dining area is accessible but the restrooms are not.",
    "Yes, they have a side entrance with a ramp for wheelchair access."
  ],
  "reservations" => [
    "Yes, you can make reservations online or by calling them directly.",
    "They don't take reservations, it's first come first served.",
    "They only take reservations for groups of 6 or more.",
    "Yes, but they only reserve half the restaurant, the rest is for walk-ins."
  ],
  "hours" => [
    "They're open Monday-Friday 9am-10pm, and weekends 10am-midnight.",
    "They open at 11am and close at 10pm every day.",
    "Weekdays 7am-6pm, closed on weekends.",
    "They're open from noon until late (around 2am) every day."
  ],
  "parking" => [
    "Yes, they have their own parking lot with about 20 spaces.",
    "No dedicated parking, but there's street parking nearby.",
    "They have a small lot, but it fills up quickly. There's a public garage two blocks away.",
    "No parking available. Public transportation is recommended."
  ],
  "vegetarian" => [
    "Yes, they have an extensive vegetarian menu.",
    "They have a few vegetarian options, but the selection is limited.",
    "They can modify many dishes to be vegetarian if you ask.",
    "Not really, it's primarily a meat-focused menu."
  ],
  "child" => [
    "Very child-friendly! They have a kids menu and high chairs.",
    "It's more of an adult atmosphere, especially in the evenings.",
    "They welcome children but don't have specific accommodations for them.",
    "During the day it's fine for kids, but evenings are more adult-oriented."
  ],
  "credit" => [
    "Yes, they accept all major credit cards.",
    "Credit cards and mobile payments accepted.",
    "Cash only.",
    "They prefer cash but do accept cards for purchases over 20 PLN."
  ],
  "dress" => [
    "No formal dress code, casual attire is fine.",
    "Smart casual - no sportswear or flip-flops.",
    "It's quite upscale, so business casual or better is recommended.",
    "No specific dress code, but most people dress nicely."
  ],
  "wifi" => [
    "Yes, they offer free Wi-Fi to customers.",
    "They have Wi-Fi but you need to ask staff for the password.",
    "No Wi-Fi available.",
    "They used to have Wi-Fi but it wasn't reliable, so they discontinued it."
  ],
  "groups" => [
    "Great for groups! They have large tables and can accommodate parties up to 20 people.",
    "Better for small groups or couples, as the space is quite intimate.",
    "They can accommodate groups if you make a reservation in advance.",
    "They have a separate room for large groups of 10 or more."
  ],
  "takeout" => [
    "Yes, they offer takeout and even have their own delivery service.",
    "Takeout is available but you need to call ahead.",
    "No takeout, dine-in only.",
    "They're on most food delivery apps."
  ],
  "outdoor" => [
    "They have a lovely patio area for outdoor seating when the weather permits.",
    "No outdoor seating available.",
    "They have a small balcony with a few tables.",
    "They set up outdoor seating during summer months only."
  ],
  "alcohol" => [
    "Full bar with an extensive wine and cocktail list.",
    "They serve beer and wine only.",
    "No alcohol served, but you can BYOB for a small corkage fee.",
    "They have a limited selection of local beers and wines."
  ],
  "business" => [
    "Great for business meetings - quiet atmosphere and good table spacing.",
    "Too noisy for serious business discussions.",
    "They have a private room you can reserve for business meetings.",
    "Better for casual business lunches than formal meetings."
  ],
  "price" => [
    "Moderate - main dishes range from 40-70 PLN.",
    "Quite expensive - expect to pay 100+ PLN per person.",
    "Very affordable - most items are under 30 PLN.",
    "Mixed pricing - you can get a quick bite for 25 PLN or go for the chef's tasting menu at 200 PLN."
  ],
  "noise" => [
    "It's usually quite quiet and good for conversation.",
    "Very lively and energetic - can get quite loud during peak hours.",
    "Moderate noise level - not too quiet, not too loud.",
    "Weekdays are quiet, but weekends can be noisy."
  ],
  "gluten" => [
    "They have a dedicated gluten-free menu.",
    "They can modify most dishes to be gluten-free upon request.",
    "Limited gluten-free options available.",
    "The staff is knowledgeable about gluten-free needs, just ask."
  ],
  "music" => [
    "They have live music on Friday and Saturday nights.",
    "No live music, just ambient background music.",
    "They occasionally have local musicians perform.",
    "They have a DJ on weekend nights."
  ],
  "busy" => [
    "It gets extremely busy on weekends - expect a 30-45 minute wait without a reservation.",
    "Moderately busy - you might wait 15 minutes for a table.",
    "Surprisingly not too busy, even on weekends.",
    "Very busy during dinner hours, but you can usually get lunch without a wait."
  ],
  "pets" => [
    "They allow dogs on the outdoor patio only.",
    "No pets allowed except service animals.",
    "Very pet-friendly - they even have treats for dogs!",
    "They officially don't allow pets, but people often bring small dogs in carriers."
  ]
}

# Map question types to answer types
question_to_answer_map = {
  "wheelchair accessible" => "wheelchair",
  "take reservations" => "reservations",
  "opening hours" => "hours",
  "parking available" => "parking",
  "vegetarian options" => "vegetarian",
  "child-friendly" => "child",
  "accept credit cards" => "credit",
  "dress code" => "dress",
  "have Wi-Fi" => "wifi",
  "good for large groups" => "groups",
  "offer takeout" => "takeout",
  "outdoor seating" => "outdoor",
  "serve alcohol" => "alcohol",
  "good for business meetings" => "business",
  "average price range" => "price",
  "noisy or quiet" => "noise",
  "gluten-free options" => "gluten",
  "live music" => "music",
  "busy" => "busy",
  "allow pets" => "pets"
}

# Create between 200-300 questions
question_count = rand(200..300)
questions_created = 0

question_count.times do
  # Select a random venue and user
  venue = venues.sample
  user = users.sample

  # Select a random question template
  template = question_templates.sample
  question_text = template % { venue_name: venue.name }

  # Create the question
  question = Question.create!(
    body: question_text,
    user: user,
    venue: venue
  )

  questions_created += 1

  # Determine how many answers this question should have (0-3)
  answer_count = rand(0..3)

  if answer_count > 0
    # Find the answer type based on question content
    answer_type = nil
    question_to_answer_map.each do |keyword, type|
      if question_text.include?(keyword)
        answer_type = type
        break
      end
    end

    # Default to random answer type if no match found
    answer_type ||= answer_templates.keys.sample

    # Get potential answers for this type
    potential_answers = answer_templates[answer_type]

    # Create the answers
    answerers = users.shuffle.take(answer_count)
    answerers.each do |answerer|
      answer_text = potential_answers.sample % { venue_name: venue.name }
      Answer.create!(
        body: answer_text,
        question: question,
        user: answerer
      )
    end
  end
end

# Update question counters
Question.find_each do |question|
  question.update_column(:count_of_answers, question.answers.count)
end

puts "Created #{questions_created} Questions with #{Answer.count} Answers."
