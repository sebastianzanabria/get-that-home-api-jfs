# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :property_id, uniqueness: { scope: :user_id, message: 'has already been clicked.' }
  validates :user_id, presence: true
  validates :property_id, presence: true
end
