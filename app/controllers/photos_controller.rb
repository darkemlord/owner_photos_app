# frozen_string_literal: true

# Photos Controller
class PhotosController < ApplicationController
  before_action :check_authentication
  def index
    @photos = @user.images
  end

  def new
    # get view to upload photos
  end

  def create
    if @user.images.attach(io: params[:image], filename: params[:title])
      redirect_to photos_path, notice: 'Photos uploaded successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def upload_errors
    error_messages = []
    error_messages.push('タイトルを入力してください。') if params[:title].blank?
    error_messages.push('画像ファイルを入力してください。') if params[:photos].blank?
  end
end
