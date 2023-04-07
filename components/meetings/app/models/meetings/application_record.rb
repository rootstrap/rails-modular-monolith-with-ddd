# frozen_string_literal: true

module Meetings
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'meetings_'

    connects_to database: { writing: :meetings, reading: :meetings }
  end
end
