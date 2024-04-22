# frozen_string_literal: true

require 'test_helper'

# Tests for sessions controller
class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(user_id: 'user14', password: 'password')
    post sessions_path, params: { user_id: @user.user_id, password: 'password' }
  end

  test 'should get index' do
    get photos_path
    assert_response :success
  end
  test 'should get new' do
    get new_photo_path
    assert_response :success
  end

  test 'should create photo' do
    image = @user.images.attach(io: fixture_file_upload('test/fixtures/files/me.jpg'), filename: 'me')
    assert_not_nil image
  end

  test 'should redirect on create with errors' do
    post photos_path params: { image: nil, title: '' }
    assert_redirected_to new_photo_path
    assert_equal ['タイトルを入力してください。', '画像ファイルを入力してください。'], flash[:alert]
  end
end
