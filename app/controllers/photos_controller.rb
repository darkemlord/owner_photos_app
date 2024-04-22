# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# Photos Controller
class PhotosController < ApplicationController
  include OauthHelper
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
    redirect_to photos_path, notice: 'ツイートが成功しました。' if tweet_photo(@photo.filename, full_photos_url, @token)
  end

  def tweet_photo(title, image_url, token)
    uri = URI('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets')
    data = { 'text': title, 'url': image_url }
    json_data = data.to_json
    request = Net::HTTP::Post.new(uri)
    request.body = json_data
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{token}"
    Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
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
