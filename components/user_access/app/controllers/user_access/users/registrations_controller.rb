# frozen_string_literal: true

module UserAccess
  class Users::RegistrationsController < Devise::RegistrationsController
    def create
      if UserRegistrationService.new(user_params).call
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :login, :email,
        :password, :password_confirmation,
        :first_name, :last_name
      )
    end
  end
end
