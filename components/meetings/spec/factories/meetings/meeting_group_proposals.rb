# frozen_string_literal: true

FactoryBot.define do
  factory :meetings_meeting_group_proposal, class: 'Meetings::MeetingGroupProposal' do
    description { 'Meeting description' }
    location_city { 'Montevideo' }
    location_country_code { 'UY' }
    name { 'Pepe' }
    proposal_date { Time.current }
    status_code { :in_verification }
    proposal_user_id { nil }
  end
end
