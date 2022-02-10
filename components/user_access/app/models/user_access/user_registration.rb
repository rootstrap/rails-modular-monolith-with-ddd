# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_user_registrations
#
#  id                   :bigint           not null, primary key
#  confirmation_sent_at :datetime
#  confirmation_token   :string
#  confirmed_at         :datetime
#  email                :string           not null
#  encrypted_password   :string           not null
#  first_name           :string           not null
#  last_name            :string           not null
#  login                :string           not null
#  name                 :string           not null
#  registered_at        :datetime         not null
#  status_code          :integer          not null
#  unconfirmed_email    :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
module UserAccess
  class UserRegistration < ApplicationRecord
    attr_reader :password, :current_password
    attr_accessor :password_confirmation

    devise :registerable, :validatable, :confirmable

    validates_uniqueness_of :email, :login
    validates_presence_of :email, :encrypted_password, :first_name, :last_name, :name,
                          :login, :registered_at, :status_code
    validates_confirmation_of :password

    enum status_code: {
      waiting_for_confirmation: 0,
      confirmed: 1,
      expired: 2
    }

    def initialize(*args, &block)
      super
      @skip_confirmation_notification = true
    end

    def password=(new_password)
      @password = new_password
      self.encrypted_password = password_digest(@password) if @password.present?
    end

    private

    def password_digest(password)
      Devise::Encryptor.digest(UserAccess::User, password)
    end

    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
end
