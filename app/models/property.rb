# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User'
  belongs_to :operation, polymorphic: true
  has_many :favorites
  has_many :lovers, through: :favorites, source: :user
  has_many :contacts
  has_many :applicants, through: :contacts, source: :user
  has_many :visits
  has_many :visitors, through: :visits, source: :user
end
