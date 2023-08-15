# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, :full_name, :username, presence: true
  validates :email, uniqueness: true
end
