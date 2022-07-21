# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings_consumed_messages
#
#  id         :bigint           not null, primary key
#  aggregate  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :uuid
#
module Meetings
  class ConsumedMessage < ApplicationRecord
    validates_presence_of :aggregate, :event_id

    def self.already_processed?(event_id, aggregate)
      exists?(event_id: event_id, aggregate: aggregate)
    end
  end
end
