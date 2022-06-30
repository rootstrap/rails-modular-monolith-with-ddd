# typed: false
module Meetings
  class CreateMemberService
    attr_reader :event_payload

    def initialize(event_payload)
      @event_payload = event_payload
    end

    def call
      member = Member.new(
        event_payload.slice(
          :identifier, :login, :email,
          :first_name, :last_name, :name
        )
      )

      member.save!
    end
  end
end
