# frozen_string_literal: true

module UserAccess
  class UserRegistration < ApplicationRecord
    attr_reader :password, :current_password
    attr_accessor :password_confirmation

    validates_confirmation_of :password

    enum status_code: {
      waiting_for_confirmation: 0,
      confirmed: 1,
      expired: 2
    }

    def password=(new_password)
      @password = new_password
      self.encrypted_password = password_digest(@password) if @password.present?
    end

    private

    def password_digest(password)
      Devise::Encryptor.digest(UserAccess::User, password)
    end
  end
end
