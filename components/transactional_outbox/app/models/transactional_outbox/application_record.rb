# frozen_string_literal: true

module TransactionalOutbox
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'transactional_outbox_'
  end
end
