# frozen_string_literal: true

def login_as(user = Fabricate(:user))
  sign_in user
end
