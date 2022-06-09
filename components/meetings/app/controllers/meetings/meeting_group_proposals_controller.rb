module Meetings
  class MeetingGroupProposalsController < ApplicationController
    before_action :authenticate_user!

    def new; end

    def create
      result = CreateMeetingGroupProposalService.new(
        meeting_group_proposal_params,
        current_user.identifier
      ).call

      if result
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def meeting_group_proposal_params
      params.require(:meeting_group_proposal).permit(
        :description, :location_city, :location_country_code, :name
      )
    end
  end
end
