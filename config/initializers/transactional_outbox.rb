TransactionalOutbox.configure do |config|
  config.outbox_mapping = {
    'UserAccess' => UserAccess::Outbox,
    'Meetings' => Meetings::Outbox
  }
end
