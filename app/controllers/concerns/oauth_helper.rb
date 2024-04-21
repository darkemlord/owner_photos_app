# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# Oauth requests controller
module OauthHelper
  extend ActiveSupport::Concern

  def exchange_code_for_token(code)
    uri = URI.parse('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token')
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/x-www-form-urlencoded'
    request.set_form_data(
      'grant_type' => 'authorization_code',
      'code' => code,
      'redirect_uri' => 'http://localhost:3000/oauth/callback',
      'client_id' => ENV['CLIENT_ID'],
      'client_secret' => ENV['CLIENT_SECRET']
    )
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      json_response = JSON.parse(response.body)
      json_response['access_token']
    end
  end
end
