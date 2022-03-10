# frozen_string_literal: true

FactoryBot.define do
  factory :user_access_user_registration, class: 'UserAccess::UserRegistration' do
    confirmation_sent_at { 1.day.ago }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    confirmation_token { SecureRandom.uuid }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    name { "#{first_name} #{last_name}" }
    login { Faker::Internet.username }
    registered_at { rand(9).days.ago }
    status_code { UserAccess::UserRegistration.status_codes.values.sample }
  end
end
