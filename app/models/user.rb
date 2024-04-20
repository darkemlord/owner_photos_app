# frozen_string_literal: true

# Table name: users
class User < ApplicationRecord
  has_secure_password
  validates :user_id, presence: { message: 'ウーザーIDを入力してください。' },
                      uniqueness: { message: 'このユーザーIDはすでに使用されています。' }
  validates :password, presence: { message: 'パスワードを入力してください。' }
end
