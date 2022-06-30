# typed: false
module UserAccess
  class ConfirmUserRegistrationService
    attr_reader :confirmation_token

    def initialize(confirmation_token)
      @confirmation_token = confirmation_token
    end

    def call
      return false if !pending_confirmation? || confirmation_period_expired?

      user_registration.status_code = :confirmed
      user_registration.confirmed_at = Time.current
      valid = user_registration.save

      if valid
        ActiveSupport::Notifications.instrument(
          'user_registration_confirmed_domain_event.user_access',
          user_registration_confirmed_domain_event
        )
      end

      valid
    end

    private

    def user_registration
      @user_registration ||= UserRegistration.find_by(confirmation_token: confirmation_token)
    end

    def pending_confirmation?
      user_registration.confirmed_at.blank?
    end

    def confirmation_period_expired?
      Time.current > (user_registration.confirmation_sent_at.utc + user_registration.class.confirm_within)
    end

    def user_registration_confirmed_domain_event
      {
        user_registration_id: user_registration.id
      }
    end
  end
end
