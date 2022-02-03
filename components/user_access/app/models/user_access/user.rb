# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
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
#  unconfirmed_email      :string
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
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :confirmable
  end
end
