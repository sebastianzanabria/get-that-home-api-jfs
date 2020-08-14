# frozen_string_literal: true

class User < ApplicationRecord
  has_many :properties, foreign_key: :landlord_id
end
