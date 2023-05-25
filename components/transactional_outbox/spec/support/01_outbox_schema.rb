RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{components/transactional_outbox/spec/}) do |metadata|
    metadata[:transactional_outbox] = true
  end

  config.before :each, transactional_outbox: true do
    ActiveRecord::Base.connection.create_table :custom_outbox_test_models do |t|
      t.uuid :identifier, null: false
    end

    ActiveRecord::Base.connection.create_table :default_outbox_test_models do |t|
      t.uuid :identifier, null: false
    end

    ActiveRecord::Base.connection.create_table :custom_outbox_outboxes do |t|
      t.uuid :identifier, null: false, index: { unique: true }
      t.string :event, null: false
      t.jsonb :payload
      t.string :aggregate, null: false
      t.uuid :aggregate_identifier, null: false

      t.timestamps
    end
  end
end
