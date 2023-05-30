# frozen_string_literal: true

def login_as_user(user = Fabricate(:user))
  sign_in user
end
