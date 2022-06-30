# typed: false
# frozen_string_literal: true

module UserAccess
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'user_access_'
  end
end
