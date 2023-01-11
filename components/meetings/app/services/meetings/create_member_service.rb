module Meetings
  class CreateMemberService
    attr_reader :event_payload

    def initialize(event_payload)
      @event_payload = event_payload
    end

    def call
      Meetings::OutboxService.new.create!(event: Meetings::Events::MEMBER_CREATED_SUCCESS) do
        member = Member.new(
          event_payload.slice(
            'identifier', 'login', 'email',
            'first_name', 'last_name', 'name'
          )
        )

        member.save!
        member
      end
      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => exception
      Rails.logger.error { exception.message }
      Meetings::OutboxService.new.create!(event: Meetings::Events::MEMBER_CREATED_FAILURE) { member }
      false
    end
  end
end
