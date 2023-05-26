# frozen_string_literal: true

class User < ApplicationRecord
  include Authenticable
  PASSWORD_PATTERN = /(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}/

  before_validation :password_complexity, on: :create

  private
  
  def password_complexity
    return if password.match?(PASSWORD_PATTERN)

    errors.add(:password, :invalid)
  end
end
