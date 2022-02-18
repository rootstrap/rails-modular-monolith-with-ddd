# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  ActiveSupport::Notifications.subscribe('new_user_registered_domain_event.user_access') do |event|
    UserAccess::SendUserConfirmationEmailService.new(event.payload[:user_registration_id]).call
  end
end
