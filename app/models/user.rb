# frozen_string_literal: true

# Table name: users
class User < ApplicationRecord
  has_many_attached :images
  has_secure_password
  validates :user_id, presence: { message: 'ウーザーIDを入力してください。' },
                      uniqueness: { message: 'このユーザーIDはすでに使用されています。' }
end
