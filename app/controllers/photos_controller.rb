# frozen_string_literal: true

# Photos Controller
class PhotosController < ApplicationController
  before_action :authenticated_user
  def index
    @photos = @user.ordered_images
  end

  def new
    # get view to upload photos
  end

  def create
    if check_params && @user.images.attach(io: params[:image], filename: params[:title])
      redirect_to photos_path
    else
      redirect_to new_photo_path, notice: upload_errors
    end
  end

  def upload_errors
    error_messages = []
    error_messages.push('タイトルを入力してください。') if params[:title].blank?
    error_messages.push('画像ファイルを入力してください。') if params[:image].blank?
  end

  def check_params
    params[:title].present? && params[:image].present?
  end
end
