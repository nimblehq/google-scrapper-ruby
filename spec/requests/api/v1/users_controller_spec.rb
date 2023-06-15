# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST /api/v1/users' do
    context 'when a user registers' do
      let(:create_user_params) do
        application ||= Fabricate(:application)
        {
          email: 'dummy@dummy.com',
          password: 'aaaaaaA1',
          client_id: application.uid
        }
      end

      context 'given valid params' do
        it 'returns the user' do
          post '/api/v1/users', params: create_user_params
          expect(JSON.parse(response.body)['user']['email']).to eq('dummy@dummy.com')
          expect(response).to have_http_status(:success)
        end
      end

      context 'given an existing email' do
        it 'receives an error' do
          User.create(email: 'user@demo.com', password: 'Secret@11')
          post '/api/v1/users', params: create_user_params.merge(email: 'user@demo.com')
          expect(JSON.parse(response.body).keys).to contain_exactly('error')
        end
      end

      context 'given an invalid password' do
        it 'receives an error' do
          post '/api/v1/users', params: create_user_params.merge(password: '123')
          expect(JSON.parse(response.body).keys).to contain_exactly('error')
        end
      end

      context 'given an invalid client_id' do
        it 'receives an error' do
          post '/api/v1/users', params: create_user_params.merge(client_id: 'not valid')
          expect(JSON.parse(response.body).keys).to contain_exactly('error')
        end
      end
    end
  end
end
