# == Schema Information
#
# Table name: user_access_outboxes
#
#  id                   :uuid             not null, primary key
#  aggregate            :string           not null
#  aggregate_identifier :uuid             not null
#  event                :string           not null
#  payload              :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
module UserAccess
  class Outbox < ApplicationRecord
    validates_presence_of :payload, :aggregate, :aggregate_identifier, :event
  end
end
