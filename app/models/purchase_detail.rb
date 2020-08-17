class PurchaseDetail < ApplicationRecord
    has_many :properties, as: :operation
end
