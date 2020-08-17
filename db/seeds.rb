# frozen_string_literal: true

require 'faker'

QTY_USERS = 50
PCT_LANDLORDS = 0.2
PCT_SUPERLANDLORDS = 0.4

puts 'Creating users'
User.create!(name: 'Landlord Test', email: 'landlordtest@mail.com', password: '123456', role: 'landlord')
User.create!(name: 'Home Seeker Test', email: 'homeseekertest@mail.com', password: '123456', role: 'home_seeker')
QTY_USERS.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.email(name: name)
  phone_number = Faker::PhoneNumber.cell_phone
  role = rand < PCT_LANDLORDS ? 'landlord' : 'home_seeker'
  User.create!(name: name, email: email, password: '123456', phone_number: phone_number, role: role)
end

APARTMENT_AMENETIES = ['Central Air Conditioning', 'Stove', 'Fridge', 'TV', 'Laundry room', 'Balcony',
                       'Furnished', 'Dishwasher', 'Closets', 'Walk-in closet', 'Dog room'].freeze
BUILDING_AMENETIES = ['Parking spot', 'Park', 'Child pool', 'Pool', '24/7 surveillance', 'Access Control',
                      'Dog park', 'Barbecue', 'Roof pool', 'Fitness center', 'Business center',
                      'Childcare center', 'Playground'].freeze
CLOSE_BY = ['Supermarket', 'Minimarket', 'Ramen restaurant', 'Restaurants', 'Child school', 'University',
            'Park', 'Dog school'].freeze

puts 'Creating properties'
landlord_ids = User.where(['role = :role', { role: 'landlord' }]).map(&:id)
home_seekers = User.where(['role = :role', { role: 'home_seeker' }])

landlord_ids.push(*landlord_ids.sample((landlord_ids.length * PCT_SUPERLANDLORDS).ceil))

landlord_ids.each do |id|
  address = Faker::Address.street_address
  district = Faker::Address.city
  province = Faker::Address.state
  property_type = %w[apartment house].sample
  bedrooms = rand(1..5)
  bathrooms = rand(1..3)
  area = rand(20..100)
  apartment_ameneties = APARTMENT_AMENETIES.sample(rand(4..7))
  building_ameneties = BUILDING_AMENETIES.sample(rand(4..6))
  close_by = CLOSE_BY.sample(rand(3..5))
  pets_allowed = [true, false].sample
  description =  Faker::Lorem.paragraph
  is_available = [true, false].sample
  operation_type = %w[renting buying].sample
  property = Property.create!(
    address: address, district: district, province: province, property_type: property_type,
    bedrooms: bedrooms, bathrooms: bathrooms, area: area, apartment_ameneties: apartment_ameneties,
    building_ameneties: building_ameneties, close_by: close_by, pets_allowed: pets_allowed,
    description: description, is_available: is_available, operation_type: operation_type,
    landlord_id: id
  )
  property.lovers.push(*home_seekers.sample(rand(4..10)))
  property.applicants.push(*home_seekers.sample(rand(4..6)))
  unq_visitors = [*home_seekers.sample(rand(4..10)), *property.lovers, *property.applicants].uniq
  property.visitors.push(*unq_visitors)
end
