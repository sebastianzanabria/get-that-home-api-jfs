# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :valid_home_seeker?, only: %i[create destroy]
  before_action :set_favorite, only: [:destroy]

  def create
    @favorite = Favorite.new(favorite_params)
    if @favorite.save
      render json: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @favorite
      @favorite.destroy
      render json: @favorite
    else
      errors = { errors: { message: "The relation doesn't exist" } }
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def set_favorite
    @favorite = Favorite.find_by(favorite_params)
  end

  def favorite_params
    params.permit(:property_id).merge({ user: current_user })
  end
end
