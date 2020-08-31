# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::MethodNotAllowed, with: :render_405
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

  def render_404
    errors = { errors: { message: 'Record not found' } }
    render json: errors, status: :unprocessable_entity
  end

  def render_405
    errors = { errors: { message: 'Method not allowed' } }
    render json: errors, status: :method_not_allowed
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end
end
