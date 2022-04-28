# frozen_string_literal: true

FactoryBot.define do
  factory :meetings_meeting_group, class: 'Meetings::MeetingGroup' do
    description { 'Meeting description' }
    location_city { 'Montevideo' }
    location_country_code { 'UY' }
    name { 'Pepe' }
    payment_date_to { 1.month.from_now }
    creator_id { nil }
    meeting_group_proposal_id { nil }
  end
end
