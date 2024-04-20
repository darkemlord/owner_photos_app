# frozen_string_literal: true

# Main Controller
class ApplicationController < ActionController::Base
  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def authenticated_user
    redirect_to photos_path if current_user
  end

  def check_authentication
    redirect_to root_path if current_user.nil?
  end
end
