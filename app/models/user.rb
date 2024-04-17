# frozen_string_literal: true

# Table name: users
class User < ApplicationRecord
  # alias_attribute :password_digest, :user_password
  has_secure_password
  validates :user_id, presence: true
  validates :user_password, presence: true
end
