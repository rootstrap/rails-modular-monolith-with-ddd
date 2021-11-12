# frozen_string_literal: true

FactoryBot.define do
  factory :user_access_user, class: 'UserAccess::User' do
    email { Faker::Internet.unique.email }
    password { 'password123' }
    confirmed_at { Faker::Date.between(from: 10.days.ago, to: Time.zone.today) }
  end
end
