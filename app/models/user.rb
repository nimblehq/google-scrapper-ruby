# frozen_string_literal: true

class User < ApplicationRecord

  include Authenticable

  def password_complexity
    return if password.blank? || password.match?(/(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}/)

    errors.add(:password, 'must include at least one uppercase letter, one lowercase letter, and one digit')
  end

end
