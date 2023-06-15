# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  included do
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

    # the authenticate method from devise documentation
    # todo extract it inside authenticable
    def self.authenticate(email, password)
      user = User.find_for_authentication(email: email)
      user&.valid_password?(password) ? user : nil
    end
  end
end
