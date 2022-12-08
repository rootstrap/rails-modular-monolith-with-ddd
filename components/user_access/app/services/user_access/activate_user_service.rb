module UserAccess
  class ActivateUserService
    attr_reader :user_identifier

    def initialize(event_payload)
      @user_identifier = event_payload['identifier']
    end

    def call
      UserAccess::OutboxService.new.create!(event: UserAccess::Events::USER_ACTIVATION_SUCCEEDED) do
        user.update!(status: :active)
        user
      end
      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => exception
      Rails.logger.error { exception.message }
      # TODO: Handle failure events inside the OutboxService.create! method
      UserAccess::OutboxService.new.create!(event: UserAccess::Events::USER_ACTIVATION_FAILED) do
        user.update!(status: :failed)
        user
      end
      false
    end

    private

    def user
      @user ||= User.find_by(identifier: user_identifier)
    end
  end
end
