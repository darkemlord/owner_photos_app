# frozen_string_literal: true

# Photos Controller
class PhotosController < ApplicationController
  before_action :check_authentication
  def index
    @photos = []
  end
end
