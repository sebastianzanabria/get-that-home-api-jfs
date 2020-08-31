# frozen_string_literal: true

class VisitsController < ApplicationController
  before_action :valid_home_seeker?, only: %i[create]

  def create
    @visit = Visit.new(visit_params)
    if @visit.save
      render json: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  private

  def visit_params
    params.permit(:property_id).merge({ user: current_user })
  end
end
