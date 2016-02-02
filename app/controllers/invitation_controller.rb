class InvitationController < ApplicationController
    def index
        invitation_invitees = Invitation.joins(:invitees).select('
            invitations.id as invitation_id,
            invitations.name as invitation_name,
            invitations.plus_one,
            invitations.responded,
            invitees.id as invitee_id,
            invitees.name as invitee_name,
            invitees.accepted
        ').where('invitations.email = ?', params[:email])

        if invitation_invitees.blank?
            invitation = nil
        else
            invitation = {
                id: invitation_invitees.first.invitation_id,
                name: invitation_invitees.first.invitation_name,
                plus_one: invitation_invitees.first.plus_one,
                responded: invitation_invitees.first.responded,
                invitees: []
            }

            invitation_invitees.each do |invitation_invitee|
                invitation[:invitees].append({
                                                  id: invitation_invitee.invitee_id,
                                                  name: invitation_invitee.invitee_name,
                                                  accepted: invitation_invitee.accepted
                                              })
            end
        end

        return head :not_found if invitation.nil?
        return head :accepted if invitation[:responded]
        render json: invitation
    end

    def update
        invitation = Invitation.find(params[:id])
        invitation.update_attributes!(responded: true, response_date: Time.now.utc)

        params[:invitees].each do |invitee|
            Invitee.find(invitee[:id]).update_attributes!(accepted: invitee[:accepted] == 'true')
        end

        if params[:invitation] && params[:invitation][:plus_one_going] == 'true'
            Invitee.create!(name: params[:invitation][:plus_one_name], accepted: true, invitation: invitation)
        end

        head :ok
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end

    def thanks
        @invitees = Invitee.where(invitation_id: params[:id], accepted: true).order(:name).pluck(:name)
    end
end
