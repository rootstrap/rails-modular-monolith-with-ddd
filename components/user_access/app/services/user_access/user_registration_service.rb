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

      valid = user_registration.save

      if valid
        ActiveSupport::Notifications.instrument(
          'new_user_registered_domain_event.user_access',
          new_user_registered_domain_event
        )
      end

      valid
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

    def new_user_registered_domain_event
      {
        identifier: user_registration.identifier,
        user_registration_id: user_registration.id,
        login: login,
        email: email,
        first_name: first_name,
        last_name: last_name,
        name: "#{first_name} #{last_name}",
        registered_at: registered_at
      }
    end
  end
end
