# frozen_string_literal: true

# Sessions Controller
class SessionsController < ApplicationController
  def show
    @user = User.new
  end

  def create
    @user = User.new(session_params)
    if @user.valid?
      redirect_to root_path, notice: 'Session Started'
    else
      puts '=============='
      puts sessions_path
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:user_id, :user_password)
  end
end
