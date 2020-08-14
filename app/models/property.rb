# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User'
end
