# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Other Devise configurations

  validate :password_complexity, if: :password_required?

  def password_complexity
    return if password.blank? || password.match?(/(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}/)

    errors.add(:password, 'must include at least one uppercase letter, one lowercase letter, and one digit')
  end

  private

  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end
end