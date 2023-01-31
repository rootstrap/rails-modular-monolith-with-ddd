module UserAccess
  class RollbackCreateUserService < BaseService
    attr_reader :identifier

    def initialize(event_payload)
      @identifier = event_payload['identifier']
    end

    # TODO: Send events for successful rollback or failure to do so
    def call
      ActiveRecord::Base.transaction do
        raise ActiveRecord::Rollback unless user.present? && user_registration.present?

        user.destroy!
        user_registration.update!(status_code: :waiting_for_confirmation)
      end
    rescue ActiveRecord::RecordNotDestroyed, ActiveRecord::RecordInvalid, ActiveRecord::Rollback => exception
      Rails.logger.error { exception.message }
      false
    end

    private

    def user_registration
      @user_registration ||= UserRegistration.find_by(identifier: identifier)
    end

    def user
      @user ||= User.find_by(identifier: identifier)
    end
  end
end
