# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_role_to_permissions
#
#  id              :bigint           not null, primary key
#  permission_code :string           not null
#  role_code       :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_user_access_role_to_permissions_on_permission_code  (permission_code)
#  index_user_access_role_to_permissions_on_role_code        (role_code)
#
module UserAccess
  class RoleToPermission < ApplicationRecord
    belongs_to :permission, primary_key: :code, foreign_key: :permission_code
    belongs_to :user_role, primary_key: :role_code, foreign_key: :role_code
  end
end
