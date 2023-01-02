# == Schema Information
#
# Table name: meetings_outboxes
#
#  id                   :bigint           not null, primary key
#  aggregate            :string           not null
#  aggregate_identifier :uuid             not null
#  event                :string           not null
#  identifier           :uuid             not null
#  payload              :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_meetings_outboxes_on_identifier  (identifier) UNIQUE
#
module Meetings
  class Outbox < ApplicationRecord
    validates_presence_of :identifier, :payload, :aggregate, :aggregate_identifier, :event
  end
end
