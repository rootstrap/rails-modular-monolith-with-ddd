# typed: true

module UserAccess
  class UserAuthenticationService
    extend T::Sig

    sig {params(warden: Object).void}
    def initialize(warden)
      @warden = warden
    end

    sig {void}
    def authenticate_user!
      warden.authenticate!(scope: :user)
    end

    sig {returns(String)}
    def current_user_identifier
      @current_user_identifier ||= warden.authenticate(scope: :user)&.identifier
    end

    private

    attr_reader :warden
  end
end
