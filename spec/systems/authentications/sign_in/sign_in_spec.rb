# frozen_string_literal: true

require 'rails_helper'

describe 'Sign in page', type: :system do
  let(:selectors) do
    {
      auth_form: '.new_user',
      email_field: 'user[email]',
      password_field: 'user[password]'
    }
  end

  context 'given the Sign in button is clicked' do
    context 'given the credentials are valid' do
      it 'displays the home page' do
        visit new_user_session_path
        user = Fabricate.build(:user)
        submit_authentication_form(user.email, user.password)

        expect(page).to have_current_path(root_path)
      end
    end

    context 'given the credentials are invalid' do
      it 'displays the Sign in page' do
        visit new_user_session_path
        user = Fabricate.build(:user, password: 'password')

        submit_authentication_form(user.email, 'invalid')

        expect(page).to have_current_path(root_path)
      end

      it 'shows the error message' do
        visit new_user_session_path
        user = Fabricate.build(:user, password: 'password')

        submit_authentication_form(user.email, 'invalid')

        expect(page).to have_text 'Invalid Email or password.'
      end
    end
  end

  private

  def submit_authentication_form(email, password)
    within selectors[:auth_form] do
      fill_in selectors[:email_field], with: email
      fill_in selectors[:password_field], with: password
      click_button 'Log in'
    end
  end
end
