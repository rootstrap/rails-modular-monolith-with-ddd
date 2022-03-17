module Meetings
  class CreateMemberService
    attr_reader :user_registration_id

    def initialize(user_registration_id)
      @user_registration_id = user_registration_id
    end

    def call
      # TODO: pending write implementation
      Meetings::Member.new()
    end

    private

    def user_registration
      UserAccess::UserRegistration.find(user_registration_id)
    end
  end
end
