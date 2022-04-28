# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  ActiveSupport::Notifications.subscribe('meeting_group_proposal_accepted_domain_event.administration') do |event|
    Meetings::AcceptMeetingGroupProposalService.new(event.payload).call
  end
end
