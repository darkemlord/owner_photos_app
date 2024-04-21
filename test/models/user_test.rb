# frozen_string_literal: true

require 'test_helper'

# Tests for User model
class UserTest < ActiveSupport::TestCase
  test 'Should save a valid user' do
    user = User.new(user_id: 'user10', password: 'password')
    assert user.valid?, 'The user was invalid'
  end

  test 'Should not accept user without user_id' do
    user = User.new(user_id: '', password: 'password')
    assert_not user.valid?, 'The user was valid.'
  end

  test 'Should not accept user without password' do
    user = User.new(user_id: 'user11', password: '')
    assert_not user.valid?, 'The user was valid.'
  end

  test 'Should not accept same user' do
    user = User.new(user_id: 'user0', password: 'password')
    assert_not user.valid?, 'The user was valid.'
  end
end
