# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# Photos Controller
class PhotosController < ApplicationController
  before_action :authenticated_user
  def index
    @photos = @user.ordered_images
    @token = session[:access_token] if session[:access_token]
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
    redirect_to photos_path if tweet_photo(@photo.filename, full_photos_url)
  end

  private

  def tweet_photo(title, image_url)
    uri = URI('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@token}")
    request.body = { text: title, url: image_url }.to_json
    response = http.request(request)
    response.is_a?(Net::HTTPSuccess)
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
