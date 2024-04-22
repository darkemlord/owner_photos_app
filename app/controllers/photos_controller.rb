# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# Photos Controller
class PhotosController < ApplicationController
  include OauthHelper
  include TweetHelper
  helper_method :oauth_authorize_url
  before_action :authenticated_user
  before_action :current_token, only: %i[index tweet]
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
      redirect_to new_photo_path, alert: upload_errors
    end
  end

  def tweet
    @photo = @user.images.find(params[:id])
    full_photos_url = url_for(controller: 'photos', action: 'index', only_path: false, host: request.host_with_port)
    tweet_photo(@photo.filename, full_photos_url, @token)
  end

  private

  def upload_errors
    error_messages = []
    error_messages.push('タイトルを入力してください。') if params[:title].blank?
    error_messages.push('画像ファイルを入力してください。') if params[:image].blank?
  end

  def check_params
    params[:title].present? && params[:image].present?
  end

  def current_token
    @token = session[:access_token] if session[:access_token]
  end
end
