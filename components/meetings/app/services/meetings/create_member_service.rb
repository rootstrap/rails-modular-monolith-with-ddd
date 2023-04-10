module Meetings
  class CreateMemberService
    attr_reader :event_payload

    def initialize(event_payload)
      @event_payload = event_payload
    end

    def call
      member.save!(outbox_event: Meetings::Events::MEMBER_CREATED_SUCCEEDED)
      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => exception
      Rails.logger.error { exception.message }
      payload = { before: nil, after: nil }
      payload[:after] = member.as_json
      Meetings::Outbox.create!(
        event: Meetings::Events::MEMBER_CREATED_FAILED,
        aggregate: Meetings::Member,
        aggregate_identifier: nil,
        identifier: SecureRandom.uuid,
        payload: payload
      )
      false
    end

    private

    def member
      @member ||= Member.new(
        event_payload.slice(
          'identifier', 'login', 'email',
          'first_name', 'last_name', 'name'
        )
      )
    end
  end
end
