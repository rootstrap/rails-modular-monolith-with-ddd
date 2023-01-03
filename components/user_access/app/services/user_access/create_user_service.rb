module UserAccess
  class CreateUserService
    attr_reader :user_registration_id

    def initialize(event_payload)
      @user_registration_id = event_payload['id']
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

    private

    def user_registration
      @user_registration ||= UserRegistration.find(user_registration_id)
    end
  end
end
