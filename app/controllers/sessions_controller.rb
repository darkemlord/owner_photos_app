# frozen_string_literal: true

# Sessions Controller
class SessionsController < ApplicationController
  before_action :check_authentication, only: [:new]
  def new
    @user |= User.new
  end

  def create
    @user = User.find_by(user_id: params[:user_id])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to photos_path
    else
      redirect_to sessions_path, notice: login_errors
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  # Even the server and the model handle this
  # It's better to handle it from the UI
  def login_errors
    error_messages = []
    add_blank_field_errors(error_messages)
    add_authentication_error(error_messages)
    error_messages
  end

  private

  def add_blank_field_errors(error_messages)
    error_messages.push('ウーザーIDを入力してください。') if params[:user_id].blank?
    error_messages.push('パスワードを入力してください。') if params[:password].blank?
  end

  def add_authentication_error(error_messages)
    error_messages.push('ユーザーID、もしくはパスワードが正しくありません。') if fields_present?
  end

  def fields_present?
    !params[:user_id].blank? && !params[:password].blank?
  end

  def session_params
    params.require(:user).permit(:user_id, :password)
  end
end
