# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_permissions
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_user_access_permissions_on_code  (code)
#
module UserAccess
  class Permission < ApplicationRecord
  end
end
