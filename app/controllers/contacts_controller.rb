# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_property, only: [:create]
  # Missing a way to restrict landlords role for create

  def create
    if current_user.role != 'home_seeker'
      raise ActionController::MethodNotAllowed
    end

    current_user.contacted_properties << @property
    render json: @property
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end
end
