# frozen_string_literal: true

FactoryBot.define do
  factory :meetings_member, class: 'Meetings::Member' do
    identifier { SecureRandom.uuid }
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    name { "#{first_name} #{last_name}" }
    login { Faker::Internet.username }
  end
end
