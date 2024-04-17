# frozen_string_literal: true

# Table name: users
class User < ApplicationRecord
  # alias_attribute :password_digest, :user_password
  # has_secure_password
  validates :user_id, presence: { message: 'ウーザーIDを入力してください。' }
  validates :user_password, presence: { message: 'パスワードを入力してください。' }
end
