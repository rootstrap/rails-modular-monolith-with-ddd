# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  is_active              :boolean          not null
#  last_name              :string           not null
#  login                  :string           not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_user_access_users_on_email                 (email) UNIQUE
#  index_user_access_users_on_reset_password_token  (reset_password_token) UNIQUE
#
module UserAccess
  class User < ApplicationRecord
    devise :registerable, :database_authenticatable, :recoverable,
           :rememberable, :validatable

    private

    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
end
