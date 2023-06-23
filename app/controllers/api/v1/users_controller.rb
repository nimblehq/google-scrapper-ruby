# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: %i[create]

      def create
        user = build_user
        client_app = find_client_application

        return render(json: { error: 'Invalid client ID' }, status: :forbidden) unless client_app

        if user.save
          access_token = create_access_token(user, client_app)
          render_success_response(user, access_token)
        else
          render_failure_response(user)
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def build_user
        User.new(email: user_params[:email], password: user_params[:password])
      end

      def find_client_application
        Doorkeeper::Application.find_by(uid: params[:client_id])
      end

      def generate_refresh_token
        loop do
          token = SecureRandom.hex(32)
          break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
      end

      def create_access_token(user, client_app)
        Doorkeeper::AccessToken.create(
          resource_owner_id: user.id,
          application_id: client_app.id,
          refresh_token: generate_refresh_token,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ''
        )
      end

      def render_success_response(user, access_token)
        user_data = build_user_data(user, access_token)
        render(json: { user: user_data })
      end

      def build_user_data(user, access_token)
        {
          id: user.id,
          email: user.email,
          access_token: access_token.token,
          token_type: 'bearer',
          expires_in: access_token.expires_in,
          refresh_token: access_token.refresh_token,
          created_at: access_token.created_at.to_time.to_i
        }
      end

      def render_failure_response(user)
        render(json: { error: user.errors.full_messages }, status: :unprocessable_entity)
      end
    end
  end
end
