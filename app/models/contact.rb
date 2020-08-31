# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :user_id, uniqueness: { scope: :property_id, message: 'already asked for contact info.' }
end
