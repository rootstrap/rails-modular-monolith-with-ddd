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
#  identifier           :uuid             not null
#  last_name            :string           not null
#  login                :string           not null
#  name                 :string           not null
#  registered_at        :datetime         not null
#  status_code          :integer          not null
#  unconfirmed_email    :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_user_access_user_registrations_on_identifier  (identifier) UNIQUE
#
module UserAccess
  class UserRegistration < ApplicationRecord
    include TransactionalOutbox::Outboxable

    devise :database_authenticatable, :registerable, :validatable, :confirmable

    validates_uniqueness_of :identifier, :email, :login
    validates_presence_of :identifier, :email, :encrypted_password, :first_name, :last_name, :name,
                          :login, :registered_at, :status_code

    enum status_code: {
      waiting_for_confirmation: 0,
      confirmed: 1,
      expired: 2
    }

    def initialize(*args, &block)
      super
      @skip_confirmation_notification = true
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
