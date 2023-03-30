# frozen_string_literal: true

module DefaultOutbox
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'default_outbox_'
  end
end
