# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_consumed_messages
#
#  id         :bigint           not null, primary key
#  aggregate  :string
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :uuid
#
# Indexes
#
#  index_user_access_consumed_messages_on_event_id_and_aggregate  (event_id,aggregate) UNIQUE
#  index_user_access_consumed_messages_on_status                  (status)
#
module UserAccess
  class ConsumedMessage < ApplicationRecord
    enum status: {
      processing: 0,
      succeeded: 1,
      failed: 2
    }

    validates_presence_of :aggregate, :event_id

    def self.already_processed?(event_id, aggregate)
      exists?(event_id: event_id, aggregate: aggregate, status: [:processing, :succeeded])
    end
  end
end
