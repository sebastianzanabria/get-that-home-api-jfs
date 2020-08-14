# frozen_string_literal: true

require 'faker'

10.times do
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    password: Faker::Alphanumeric.alpha(number: 12),
    phone_number: Faker::PhoneNumber.cell_phone,
    role: %w[landlord home_seeker].sample
  )
  p 'user created!'
end

20.times do
  Property.create!(
    address: Faker::Address.street_address,
    district: Faker::Address.city,
    province: Faker::Address.state,
    property_type: %w[apartment house].sample,
    bedrooms: rand(1..5),
    bathrooms: rand(1..3),
    area: rand(20..100),
    apartment_ameneties: [['washing machine', 'fitness center'].sample, ['business center', 'balconies'].sample, ['laundry room', 'swimming pool'].sample, ['childcare center', 'playground'].sample],
    building_ameneties: [['barbecue', 'child pool'].sample, ['roof pool', '24/7 surveillance'].sample, 'access control'],
    close_by: [%w[supermarket university].sample, ['ramen restaurant', 'washing machine'].sample],
    pets_allowed: [true, false].sample,
    description: Faker::Lorem.paragraph,
    is_available: [true, false].sample,
    operation_type: %w[renting buying].sample,
    user_id: rand(1..10)
  )
  p 'property created!'
end
