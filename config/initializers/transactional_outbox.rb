# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  TransactionalOutbox.configure do |config|
    config.outbox_mapping = {
      'UserAccess' => UserAccess::Outbox,
      'Meetings' => Meetings::Outbox
    }
  end
end
