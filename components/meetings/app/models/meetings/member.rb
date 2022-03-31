# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings_members
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  first_name :string           not null
#  identifier :uuid             not null
#  last_name  :string           not null
#  login      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_meetings_members_on_identifier  (identifier) UNIQUE
#
module Meetings
  class Member < ApplicationRecord
    validates_uniqueness_of :identifier, :email, :login
    validates_presence_of :identifier, :email, :first_name, :last_name, :name, :login
  end
end
