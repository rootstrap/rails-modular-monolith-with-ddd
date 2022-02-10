module UserAccess
  class SendUserConfirmationEmailService
    attr_reader :user_registration

    def initialize(user_registration)
      @user_registration = user_registration
    end

    def call
      user_registration.send_confirmation_instructions
    end
  end
end
