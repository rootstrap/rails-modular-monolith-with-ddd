module UserAccess
  class CreateUserService
    # attr_reader :user_registration_id

    # def initialize(event_payload)
    #   @user_registration_id = event_payload['id']
    # end

    attr_reader :identifier

    def initialize(rollback: false)
      @rollback = rollback
    end

    def self.call
      new
    end

    def self.rollback
      new(rollback: true)
    end

    def perform(event_payload)
      @identifier = event_payload['identifier']
      @rollback ? rollback : call
    end

    def call
      unless user_registration.confirmed?
        Rails.logger.info { 'User cannot be created when registration is not confirmed' }
        return
      end

      user = User.new(
        user_registration.slice(
          :identifier, :login, :email, :encrypted_password,
          :first_name, :last_name, :name
        ).merge!(status_code: :active)
      )

      user.user_roles.new(role_code: :member)
      user.skip_password_validation = true
      user.save!
    end

    def rollback
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

    # def user_registration
    #   @user_registration ||= UserRegistration.find(user_registration_id)
    # end
  end
end
