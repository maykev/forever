class InvitationController < ApplicationController
    def index
        if params[:email].blank?
            head :not_found
        end

        invitation = Invitation.find_by_email(params[:email])

        if invitation.blank?
            head :not_found
        else
            render body: invitation.id
        end
    end

    def show
        invitation_invitees = Invitation.joins(:invitees).select('invitations.id as invitation_id, invitations.name as invitation_name,
            invitees.id as invitee_id, invitees.name as invitee_name, invitees.accepted').where('invitations.id = ?', params[:id])

        if invitation_invitees.blank?
            @invitation = nil
        else
            @invitation = {
                id: invitation_invitees.first.invitation_id,
                name: invitation_invitees.first.invitation_name,
                invitees: []
            }

            invitation_invitees.each do |invitation_invitee|
                @invitation[:invitees].append({
                                                  id: invitation_invitee.invitee_id,
                                                  name: invitation_invitee.invitee_name,
                                                  accepted: invitation_invitee.accepted
                                              })
            end
        end
    end

    def update
        Invitation.find(params[:id]).update_attributes!(responded: true, response_date: Time.now.utc)

        params[:invitees].each do |invitee|
            Invitee.find(invitee[:id]).update_attributes!(accepted: invitee[:accepted] == 'true')
        end

        head :ok
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end

    def thanks
        @invitees = Invitee.where(invitation_id: params[:id]).order(:name).pluck(:name)
    end
end
