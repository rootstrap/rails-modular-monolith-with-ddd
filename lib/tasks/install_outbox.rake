namespace :transactional_outbox do
  task :install do
    generate_migration_files
    create_models_in_domains
  end

  def generate_migration_files
    migration = <<-MIGRATION
class CreateUserAccessOutbox < ActiveRecord::Migration[7.0]
  def change
    create_table :user_access_outboxes do |t|
      t.uuid :identifier, null: false, index: { unique: true }
      t.string :event, null: false
      t.jsonb :payload
      t.string :aggregate, null: false
      t.uuid :aggregate_identifier, null: false

      t.timestamps
    end
  end
end
    MIGRATION
  end

  def create_models_in_domains
  end
end
