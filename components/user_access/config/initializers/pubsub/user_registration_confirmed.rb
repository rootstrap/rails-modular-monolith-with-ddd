# typed: strict
# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  ActiveSupport::Notifications.subscribe('user_registration_confirmed_domain_event.user_access') do |event|
    UserAccess::CreateUserService.new(event.payload).call
  end
end
