# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveModel::Serializers::JSON

  has_secure_password
  has_secure_token

  has_many :properties, foreign_key: :landlord_id
  has_many :favorites
  has_many :favorite_properties, through: :favorites, source: :property
  has_many :contacts
  has_many :contacted_properties, through: :contacts, source: :property
  has_many :visits
  has_many :visited_properties, through: :visits, source: :property

  validates_format_of :name, with: /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def invalidate_token
    update(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    user&.authenticate(password)
  end

  def attributes
    attrs = super
    attrs.except('password_digest')
  end
end
