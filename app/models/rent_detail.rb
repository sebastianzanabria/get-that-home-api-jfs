class RentDetail < ApplicationRecord
    has_many :properties, as: :operation
end
