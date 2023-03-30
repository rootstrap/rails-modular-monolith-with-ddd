TransactionalOutbox.configure do |config|
  config.outbox_mapping.merge!(
    'CustomOutbox' => 'CustomOutbox::Outbox'
  )
end
