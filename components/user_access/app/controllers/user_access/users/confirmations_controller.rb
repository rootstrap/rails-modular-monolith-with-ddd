# typed: ignore
# frozen_string_literal: true

module UserAccess
  class Users::ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new
    # def new
    #   super
    # end

    # POST /resource/confirmation
    # def create
    #   super
    # end

    # GET /resource/confirmation?confirmation_token=abcdef
    def show
      result = ConfirmUserRegistrationService.new(params[:confirmation_token]).call

      flash[:error] = "Couldn't confirm your account" unless result

      redirect_to root_path
    end

    # protected

    # The path used after resending confirmation instructions.
    # def after_resending_confirmation_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
  end
end
