# frozen_string_literal: true

Fabricator(:user) do
  email { FFaker::Internet.email }
  password { 'aaaaaaA1' }
  reset_password_token { nil }
  reset_password_sent_at { nil }
  remember_created_at { nil }
  created_at { Time.zone.now }
  updated_at { Time.zone.now }
end
