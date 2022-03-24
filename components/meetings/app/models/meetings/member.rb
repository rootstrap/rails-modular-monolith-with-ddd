# frozen_string_literal: true

module Meetings
  class Member < ApplicationRecord
    validates_uniqueness_of :identifier, :email, :login
    validates_presence_of :identifier, :email, :first_name, :last_name, :name, :login
  end
end
