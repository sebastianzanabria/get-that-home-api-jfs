# frozen_string_literal: true

class AddIndexToContacts < ActiveRecord::Migration[6.0]
  def change
    add_index :contacts, %i[user_id property_id], unique: true
  end
end
