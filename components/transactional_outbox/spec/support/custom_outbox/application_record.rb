# frozen_string_literal: true

module CustomOutbox
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'custom_outbox_'
  end
end
