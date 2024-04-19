# frozen_string_literal: true

# Sessions Controller
class SessionsController < ApplicationController
  def create
    @user = User.find_by(user_id: params[:user_id])
    if @user.present? && @user.authenticate(params[:user_password])
      # session[:user_id] = @user.id
    else
      redirect_to root_path, notice: login_errors
    end
  end

  def login_errors
    error = []
    error.push('ウーザーIDを入力してください。') if params[:user_id].blank?
    error.push('パスワードを入力してください。') if params[:user_password].blank?
    error
  end

  private

  def session_params
    params.require(:user).permit(:user_id, :user_password)
  end
end
