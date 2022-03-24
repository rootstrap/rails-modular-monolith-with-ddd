module Meetings
  class MeetingGroupProposal < ApplicationRecord
    enum status_code: {
      in_verification: 0,
      accepted: 1
    }
  end
end
