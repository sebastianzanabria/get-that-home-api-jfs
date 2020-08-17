# frozen_string_literal: true

class User < ApplicationRecord
  has_many :properties, foreign_key: :landlord_id
  has_many :favorites
  has_many :favorite_properties, through: :favorites, source: :property
  has_many :contacts
  has_many :contacted_properties, through: :contacts, source: :property
  has_many :visits
  has_many :visited_properties, through: :visits, source: :property
end
