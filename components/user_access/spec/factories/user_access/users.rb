# frozen_string_literal: true

FactoryBot.define do
  factory :user_access_user, class: 'UserAccess::User' do
    email { Faker::Internet.unique.email }
    password { 'password123' }
  end
end
