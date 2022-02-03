module UserAccess
  class SendUserConfirmationEmailService
    def initialize(email)
      @email = email
    end

    def call
      user.generate_confirmation_token! # should we do this here?
      # we actually don't have a User at this point, so we cannot generate a confirmation token

      options[:token] = 'token'
      options[:to] = @email

      send_devise_notification(:confirmation_instructions, options)
    end
  end
end
