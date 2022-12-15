module UserAccess
  class UserRegistrationService
    attr_reader :login, :password, :password_confirmation, :email, :first_name, :last_name

    def initialize(attributes)
      @login = attributes[:login]
      @password = attributes[:password]
      @password_confirmation = attributes[:password_confirmation]
      @email = attributes[:email]
      @first_name = attributes[:first_name]
      @last_name = attributes[:last_name]
    end

    def call
      return false unless user_registration.valid?

      user_registration.save!(outbox_event: UserAccess::Events::NEW_USER_REGISTERED)

      # UserAccess::OutboxService.new.create!(event: UserAccess::Events::NEW_USER_REGISTERED) do
        # user_registration
      # end
      # true
    rescue ActiveRecord::RecordInvalid => exception
      Rails.logger.error { exception.message }
      false
    end

    private

    def user_registration
      @user_registration ||= UserRegistration.new(
        identifier: SecureRandom.uuid,
        login: login,
        password: password,
        password_confirmation: password_confirmation,
        email: email,
        first_name: first_name,
        last_name: last_name,
        name: "#{first_name} #{last_name}",
        registered_at: registered_at,
        status_code: :waiting_for_confirmation
      )
    end

    def registered_at
      @registered_at ||= Time.current
    end
  end
end
