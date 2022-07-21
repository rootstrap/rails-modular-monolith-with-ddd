module UserAccess
  class SendUserConfirmationEmailService
    attr_reader :user_registration_id

    def initialize(event_payload)
      @user_registration_id = event_payload['user_registration_id']
    end

    def call
      user_registration.send_confirmation_instructions
    end

    private

    def user_registration
      UserAccess::UserRegistration.find(user_registration_id)
    end
  end
end
