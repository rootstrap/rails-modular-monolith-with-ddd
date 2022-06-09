module UserAccess
  class UserAuthenticationService
    def initialize(warden)
      @warden = warden
    end

    def authenticate_user!
      warden.authenticate!(scope: :user)
    end

    def current_user_identifier
      @current_user_identifier ||= warden.authenticate(scope: :user)&.identifier
    end

    private

    attr_reader :warden
  end
end
