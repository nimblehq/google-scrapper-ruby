# frozen_string_literal: true

require 'rails_helper'

describe 'Sign out', type: :system do
  let(:selectors) do
    {
      sign_out_button: '.sign-out-button'
    }
  end

  it 'redirects to the root page' do
    login_as
    visit root_path

    click_link selectors[:sign_out_button]

    expect(page).to have_current_path(root_path)
  end
end
