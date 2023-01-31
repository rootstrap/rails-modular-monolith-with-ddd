module UserAccess
  class SendUserConfirmationEmailService < BaseService
    attr_reader :user_registration_id

    def perform(event_payload)
      @user_registration_id = event_payload['id']
      super
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
