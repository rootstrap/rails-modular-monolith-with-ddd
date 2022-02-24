module UserAccess
  class CreateUserService
    attr_reader :user_registration_id

    def initialize(user_registration_id)
      @user_registration_id = user_registration_id
    end

    def call
      if user_registration.confirmed
        Rails.logger.info { 'User cannot be created when registration is not confirmed' }
      else
        User.create!(
          user_registration.slice(
            :login, :email, :encrypted_password,
            :first_name, :last_name, :name
          )
        )
      end
    end

    private

    def user_registration
      @user_registration ||= UserRegistration.find(user_registration_id)
    end
  end
end
