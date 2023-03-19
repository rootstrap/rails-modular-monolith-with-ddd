# Load Outbox classes in development
return unless Rails.env.development? || Rails.env.test?

Rails.application.config.to_prepare do
  outbox_subclasses = [
    UserAccess::Outbox,
    Meetings::Outbox
  ]
end
