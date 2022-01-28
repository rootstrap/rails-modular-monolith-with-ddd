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
      user_registration.save
    end

    private

    def user_registration
      UserRegistration.new(
        login: login,
        password: password,
        password_confirmation: password_confirmation,
        email: email,
        first_name: first_name,
        last_name: last_name,
        name: "#{first_name} #{last_name}",
        registered_at: Time.current,
        status_code: :waiting_for_confirmation
      )
    end
  end
end
