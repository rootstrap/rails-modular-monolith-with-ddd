module Meetings
  class CreateMemberService
    attr_reader :user_registration_id

    def initialize(user_registration_id)
      @user_registration_id = user_registration_id
    end

    def call
      member = Member.new(
        user_registration.slice(
          :identifier, :login, :email,
          :first_name, :last_name, :name
        )
      )

      member.save!
    end

    private

    def user_registration
      @user_registration ||= UserAccess::UserRegistration.find(user_registration_id)
    end
  end
end
