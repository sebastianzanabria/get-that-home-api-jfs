# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :require_login

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def render_unauthorized(message)
    errors = { errors: { message: message } }
    render json: errors, status: :unauthorized
  end

  def valid_home_seeker?
    unless current_user.role == 'home_seeker'
      errors = { errors: { message: 'Only home seekers allowed' } }
      render json: errors, status: :unauthorized
    end
  end

  def valid_landlord?
    unless current_user.role == 'landlord'
      errors = { errors: { message: 'Only landlord allowed' } }
      render json: errors, status: :unauthorized
    end
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end
end
