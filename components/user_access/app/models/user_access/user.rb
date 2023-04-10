# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  identifier             :uuid             not null
#  last_name              :string           not null
#  login                  :string           not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status_code            :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_user_access_users_on_email                 (email) UNIQUE
#  index_user_access_users_on_identifier            (identifier) UNIQUE
#  index_user_access_users_on_reset_password_token  (reset_password_token) UNIQUE
#
module UserAccess
  class User < ApplicationRecord
    devise :registerable, :database_authenticatable,
           :rememberable, :validatable

    attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

    has_many :user_roles, dependent: :destroy
    has_many :role_to_permissions, through: :user_roles, dependent: :destroy
    has_many :permissions, through: :role_to_permissions

    validates_uniqueness_of :identifier, :email, :login
    validates_presence_of :identifier, :email, :encrypted_password, :first_name, :last_name, :name,
                          :login, :status_code

    enum status_code: {
      pending: 0,
      active: 1,
      failed: 2
    }

    protected

    def password_required?
      return false if skip_password_validation

      super
    end

    private

    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
end
