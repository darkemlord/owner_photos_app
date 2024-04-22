# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# Oauth requests controller
module OauthHelper
  extend ActiveSupport::Concern

  # This functions to get the token after getting the code
  def fetch_access_token(response)
    return unless response.is_a?(Net::HTTPSuccess)

    json_response = JSON.parse(response.body)
    json_response['access_token']
  end

  def token_uri
    URI.parse('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token')
  end

  def prepare_token_request(code)
    request = Net::HTTP::Post.new(token_uri)
    request.content_type = 'application/x-www-form-urlencoded'
    request.set_form_data(
      'grant_type' => 'authorization_code',
      'code' => code,
      'redirect_uri' => oauth_callback_url(only_path: false),
      'client_id' => ENV['CLIENT_ID'],
      'client_secret' => ENV['CLIENT_SECRET']
    )
    request
  end

  def perform_http_request(request)
    Net::HTTP.start(token_uri.hostname, token_uri.port) do |http|
      http.request(request)
    end
  end

  def exchange_code_for_token(code)
    request = prepare_token_request(code)
    response = perform_http_request(request)
    fetch_access_token(response)
  end

  # This functions send the first request to get the code
  def base_oauth_url
    URI::HTTP.build(
      host: 'unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com',
      path: '/oauth/authorize'
    ).to_s
  end

  def oauth_authorize_url
    client_id = ENV['CLIENT_ID']
    scope = 'write_tweet'
    redirect_uri = oauth_callback_url(only_path: false)
    query_params = URI.encode_www_form(
      client_id: client_id,
      response_type: 'code',
      scope: scope,
      redirect_uri: redirect_uri
    )
    "#{base_oauth_url}?#{query_params}"
  end
end
