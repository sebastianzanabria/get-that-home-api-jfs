# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User'
  has_many :favorites
  has_many :lovers, through: :favorites, source: :user
  has_many :contacts
  has_many :applicants, through: :contacts, source: :user
  has_many :visits
  has_many :visitors, through: :visits, source: :user

  validates :property_type, :maintenance, :price, :bathrooms, :bedrooms, :address, :description, :area, :operation_type, :province, :district, presence: true
  validates :price, :bathrooms, :bedrooms, :area, :maintenance, numericality: true
end
