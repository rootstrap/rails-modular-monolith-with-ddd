# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  ActiveSupport::Notifications.subscribe('new_user_registered_domain_event.user_access') do |event|
    Meetings::CreateMemberService.new(event.payload).call
  end
end
