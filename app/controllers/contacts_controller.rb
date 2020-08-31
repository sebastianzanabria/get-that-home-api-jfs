# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :valid_home_seeker?, only: [:create]

  def create
    @contact = Contact.new({ user: current_user, property_id: params[:property_id] })
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
end
