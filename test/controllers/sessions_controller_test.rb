# frozen_string_literal: true

require 'test_helper'

# Tests for sessions controller
class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(user_id: 'user13', password: 'password')
  end
  test 'Should get new' do
    get new_session_path
    assert_response :success
  end

  test 'should login with valid credentials' do
    post sessions_path, params: { user_id: @user.user_id, password: 'password' }
    assert_redirected_to photos_path
    assert_equal @user.id, session[:user_id]
  end

  test 'should not login with invalid credentials' do
    post sessions_path, params: { user_id: @user.user_id, password: 'wrong_password' }
    assert_redirected_to sessions_path
    assert_not_nil flash[:alert]
    assert_nil session[:user_id]
  end

  test 'should logout user' do
    delete logout_path
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end
end
