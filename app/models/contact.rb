# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :property_id, uniqueness: { scope: :user_id, message: 'has already been contacted.' }
  validates :user_id, presence: true
  validates :property_id, presence: true
end
