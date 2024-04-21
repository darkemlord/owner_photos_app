# frozen_string_literal: true

require 'test_helper'

# Tests for sessions controller
class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(user_id: 'user13', password: 'password')
  end
  test 'Should authenticate user' do
    assert @user.valid?
  end
end
