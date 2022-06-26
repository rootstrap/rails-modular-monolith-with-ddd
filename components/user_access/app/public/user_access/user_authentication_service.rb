module UserAccess
  class UserAuthenticationService
    def initialize(warden)
      @warden = warden
    end

    def authenticate_user!
      warden.authenticate!(scope: :user)
    end

    def current_user
      @current_user ||= warden.authenticate(scope: :user)&.to_dto
    end

    private

    attr_reader :warden
  end
end
