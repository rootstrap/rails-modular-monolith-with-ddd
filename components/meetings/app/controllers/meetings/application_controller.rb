module Meetings
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!

    # TODO: rescue from Member not found error and redirect to a friendly html page

    def current_user_identifier
      user_authentication_service.current_user_identifier
    end

    def authenticate_user!
      user_authentication_service.authenticate_user!
    end

    private

    def user_authentication_service
      @user_authentication_service ||= UserAccess::UserAuthenticationService.new(request.env['warden'])
    end
  end
end
