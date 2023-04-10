module UserAccess
  class ActivateUserService
    attr_reader :user_identifier

    def initialize(event_payload)
      @user_identifier = event_payload['identifier']
    end

    def call
      user.update!(status_code: :active, outbox_event: UserAccess::Events::USER_ACTIVATION_SUCCEEDED)
      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => exception
      Rails.logger.error { exception.message }
      # TODO: Handle failure events inside the OutboxService.create! method
      user.update!(status_code: :failed, outbox_event: UserAccess::Events::USER_ACTIVATION_FAILED, validate: false)
      false
    end

    private

    def user
      @user ||= User.find_by(identifier: user_identifier)
    end
  end
end
