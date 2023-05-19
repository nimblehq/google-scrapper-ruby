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
    errors.add(:password, 'must be at least 8 characters long') if password.length < 8
  end

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
