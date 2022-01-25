# frozen_string_literal: true

module UserAccess
  class UserRegistration < ApplicationRecord
    enum status_code: {
      waiting_for_confirmation: 0,
      confirmed: 1,
      expired: 2
    }
  end
end
