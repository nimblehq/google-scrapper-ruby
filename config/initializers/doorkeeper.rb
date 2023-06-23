# frozen_string_literal: true

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (requires ORM extensions installed).
  # Check the list of supported ORMs here: https://github.com/doorkeeper-gem/doorkeeper#orms
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    # Put your resource owner authentication logic here.
    # Example implementation:
    #   User.find_by(id: session[:user_id]) || redirect_to(new_user_session_url)
  end

  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:email], params[:password])
  end

  use_refresh_token
  allow_blank_redirect_uri true
  grant_flows %w[password]
  skip_authorization do |resource_owner, client|
    true
  end

end
