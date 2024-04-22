# frozen_string_literal: true

require 'net/http'
require 'uri'

# Module to define tweet request methods
module TweetHelper
  extend ActiveSupport::Concern

  def tweet_uri
    URI('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets')
  end

  def prepare_tweet_request(uri, title, image_url, token)
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/json'
    request['Authorization'] = "Bearer #{token}"
    request.body = { 'text': title, 'url': image_url }.to_json
    request
  end

  def execute_request(request, uri)
    Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(request) }
  end

  def handle_response(response)
    if response.is_a?(Net::HTTPSuccess)
      redirect_to photos_path, notice: 'ツイートが成功しました。'
    else
      redirect_to photos_path, alert: 'ツイートできませんでした。'
    end
  end

  def handle_error(exception)
    redirect_to photos_path, alert: exception.to_s
  end

  def tweet_photo(title, image_url, token)
    uri = tweet_uri
    request = prepare_tweet_request(uri, title, image_url, token)
    response = execute_request(request, uri)
    handle_response(response)
  rescue StandardError => e
    handle_error(e)
  end
end
