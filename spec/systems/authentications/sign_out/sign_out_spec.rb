# frozen_string_literal: true

require 'rails_helper'

describe 'Sign out', type: :system do
  let(:selectors) do
    {
      sign_out_button: '.sign-out-button'
    }
  end

  it 'redirects to the login page' do
    login_as_user
    visit root_path

    click_link selectors[:sign_out_button]

    expect(page).to have_current_path(new_user_session_path)
  end
end
