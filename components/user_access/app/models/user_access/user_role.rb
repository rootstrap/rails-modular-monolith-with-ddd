# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_user_roles
#
#  id         :bigint           not null, primary key
#  role_code  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_access_user_roles_on_role_code  (role_code)
#  index_user_access_user_roles_on_user_id    (user_id)
#
module UserAccess
  class UserRole < ApplicationRecord
    belongs_to :user
    belongs_to :role_to_permission, primary_key: :role_code, foreign_key: :role_code

    enum role_code: {
      member: 0,
      administrator: 1
    }
  end
end
