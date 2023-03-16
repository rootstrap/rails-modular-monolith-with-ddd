require 'rails/generators/active_record'
module Outbox
  class OutboxGenerator < ActiveRecord::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    argument :domains, type: :array, default: [], banner: "domain domain"
    class_option :root_components_path, type: :string, default: Rails.root

    def create_migration_files
      migration_path = "#{options['root_components_path']}/db/migrate"
      migration_template(
        "migration.rb",
        "#{migration_path}/outbox_create_#{table_name}.rb",
        migration_version: migration_version
      )
    end

    def migration_version
      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    end

    def table_name
      "#{name}_outboxes"
    end
  end
end
