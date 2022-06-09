module Meetings
  class CreateMeetingGroupService
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def call
      MeetingGroup.new(
        attributes.slice(
          :description,
          :name,
          :location_city,
          :location_country_code,
          :creator_id,
          :meeting_group_proposal_id
        )
      ).save
    end

    private

    # TODO
    def add_meeting_group_member; end
  end
end
