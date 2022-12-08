# == Schema Information
#
# Table name: transactional_outbox_outboxes
#
#  id                   :bigint           not null, primary key
#  aggregate            :string           not null
#  aggregate_identifier :string           not null
#  event                :string           not null
#  identifier           :uuid             not null
#  payload              :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_transactional_outbox_outboxes_on_identifier  (identifier)
#
module Meetings
  class Outbox < TransactionalOutbox::Outbox
  end
end