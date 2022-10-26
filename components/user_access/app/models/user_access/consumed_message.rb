# frozen_string_literal: true

# == Schema Information
#
# Table name: user_access_consumed_messages
#
#  id         :bigint           not null, primary key
#  aggregate  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :uuid
#
# Indexes
#
#  index_user_access_consumed_messages_on_event_id_and_aggregate  (event_id,aggregate) UNIQUE
#
module UserAccess
  class ConsumedMessage < ApplicationRecord
    validates_presence_of :aggregate, :event_id

    def self.already_processed?(event_id, aggregate)
      exists?(event_id: event_id, aggregate: aggregate)
    end
  end
end
