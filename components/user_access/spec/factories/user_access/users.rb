# frozen_string_literal: true

FactoryBot.define do
  factory :user_access_user, class: 'UserAccess::User' do
    identifier { SecureRandom.uuid }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    name { "#{first_name} #{last_name}" }
    login { Faker::Internet.username }
    is_active { true }
  end
end
