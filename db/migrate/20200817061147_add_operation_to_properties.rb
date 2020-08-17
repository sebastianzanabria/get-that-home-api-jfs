# frozen_string_literal: true

class AddOperationToProperties < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :operation, polymorphic: true, null: false
  end
end
