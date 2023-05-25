# frozen_string_literal: true

module UserAccess
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'user_access_'

    connects_to database: { writing: :user_access, reading: :user_access }
  end
end
