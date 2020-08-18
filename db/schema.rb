# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_817_202_055) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'contacts', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'property_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['property_id'], name: 'index_contacts_on_property_id'
    t.index ['user_id'], name: 'index_contacts_on_user_id'
  end

  create_table 'favorites', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'property_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['property_id'], name: 'index_favorites_on_property_id'
    t.index ['user_id'], name: 'index_favorites_on_user_id'
  end

  create_table 'properties', force: :cascade do |t|
    t.text 'address'
    t.string 'district'
    t.string 'province'
    t.string 'property_type'
    t.integer 'bedrooms'
    t.decimal 'bathrooms'
    t.decimal 'area'
    t.string 'apartment_ameneties', default: [], array: true
    t.string 'building_ameneties', default: [], array: true
    t.string 'close_by', default: [], array: true
    t.boolean 'pets_allowed'
    t.text 'description'
    t.boolean 'is_available'
    t.string 'operation_type'
    t.bigint 'landlord_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.decimal 'price'
    t.decimal 'maintenance'
    t.index ['landlord_id'], name: 'index_properties_on_landlord_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password'
    t.string 'phone_number'
    t.string 'role'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'visits', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'property_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['property_id'], name: 'index_visits_on_property_id'
    t.index ['user_id'], name: 'index_visits_on_user_id'
  end

  add_foreign_key 'contacts', 'properties'
  add_foreign_key 'contacts', 'users'
  add_foreign_key 'favorites', 'properties'
  add_foreign_key 'favorites', 'users'
  add_foreign_key 'properties', 'users', column: 'landlord_id'
  add_foreign_key 'visits', 'properties'
  add_foreign_key 'visits', 'users'
end
