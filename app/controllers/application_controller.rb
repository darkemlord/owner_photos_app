# frozen_string_literal: true

# Main Controller
class ApplicationController < ActionController::Base
  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def check_authentication
    if current_user.nil?
      redirect_to root_path unless request.path == root_path
    else
      redirect_to photos_path unless request.path == photos_path
    end
  end
end
