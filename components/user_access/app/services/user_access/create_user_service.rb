module UserAccess
  class CreateUserService
    attr_reader :user_registration_id

    def initialize(user_registration_id)
      @user_registration_id = user_registration_id
    end

    def call
      unless user_registration.confirmed?
        Rails.logger.info { 'User cannot be created when registration is not confirmed' }
        return
      end

      user = User.new(
        user_registration.slice(
          :login, :email, :encrypted_password,
          :first_name, :last_name, :name
        ).merge!(is_active: true)
      )

      user.skip_password_validation = true
      user.save!
    end

    private

    def user_registration
      @user_registration ||= UserRegistration.find(user_registration_id)
    end
  end
end
