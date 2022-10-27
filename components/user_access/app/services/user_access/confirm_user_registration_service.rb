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

      UserAccess::OutboxService.new.create!(event: 'user_registration_confirmed_domain_event.user_access') do
        user_registration.save!
        user_registration
      end
      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => exception
      Rails.logger.error { exception.message }
      false
    end

    private

    def user_registration
      @user_registration ||= UserRegistration.find_by!(confirmation_token: confirmation_token)
    end

    def pending_confirmation?
      user_registration.confirmed_at.blank?
    end

    def confirmation_period_expired?
      Time.current > (user_registration.confirmation_sent_at.utc + user_registration.class.confirm_within)
    end
  end
end
