# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User'
  has_many :favorites
  has_many :lovers, through: :favorites, source: :user
  has_many :contacts
  has_many :applicants, through: :contacts, source: :user
  has_many :visits
  has_many :visitors, through: :visits, source: :user
  has_many_attached :images

  validates :description, presence: true

  validates :operation_type, inclusion: { in: %w[rent buy],
                                          message: '%{value} is not a valid operation type' }

  validates :property_type, inclusion: { in: %w[apartment house],
                                         message: '%{value} is not a valid property type' }

  validates :pets_allowed, inclusion: { in: [true, false], message: '%{value} is not a boolean' }
  validates :bedrooms, numericality: { greater_than: 0, only_integer: true }
  validates :price, :maintenance, :bathrooms, :area, numericality: { greater_than: 0 }
  validate :validate_apartment_ameneties
  validate :validate_building_ameneties
  validate :validate_close_by

  APARTMENT_AMENETIES_LIST = ['Central Air Conditioning', 'Stove', 'Fridge', 'TV', 'Laundry room',
                              'Balcony', 'Furnished', 'Dishwasher', 'Closets', 'Walk-in closet',
                              'Dog room'].freeze
  BUILDING_AMENETIES_LIST = ['Parking spot', 'Park', 'Child pool', 'Pool', '24/7 surveillance',
                             'Access Control', 'Dog park', 'Barbecue', 'Roof pool', 'Fitness center',
                             'Business center', 'Childcare center', 'Playground'].freeze

  CLOSE_BY_LIST = ['Supermarket', 'Minimarket', 'Ramen restaurant', 'Restaurants',
                   'Child school', 'University', 'Park', 'Dog school'].freeze

  def validate_apartment_ameneties
    if !apartment_ameneties.is_a?(Array) || apartment_ameneties.detect { |el| !APARTMENT_AMENETIES_LIST.include?(el) }
      errors.add(:apartment_ameneties, :invalid)
    end
  end

  def validate_building_ameneties
    if !building_ameneties.is_a?(Array) || building_ameneties.detect { |el| !BUILDING_AMENETIES_LIST.include?(el) }
      errors.add(:building_ameneties, :invalid)
    end
  end

  def validate_close_by
    if !close_by.is_a?(Array) || close_by.detect { |el| !CLOSE_BY_LIST.include?(el) }
      errors.add(:close_by, :invalid)
    end
  end
end
