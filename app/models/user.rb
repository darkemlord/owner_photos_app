# frozen_string_literal: true

# Table name: users
class User < ApplicationRecord
  has_secure_password
  validates :user_id, presence: { message: 'ウーザーIDを入力してください。' }
  validates :password, presence: { message: 'パスワードを入力してください。' }
end
