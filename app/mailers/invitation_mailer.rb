class InvitationMailer < ApplicationMailer
    def invitation_email(invitation)
        @invitation = invitation
        @invitees = Invitee.where(invitation: invitation, accepted: true)

        attachments['Invitation.pdf'] = File.read(Rails.root.join('app', 'assets', 'pdf', 'Invitation.pdf'))

        mail(to: invitation.email, from: "kevinandamymay@gmail.com", subject: "Amy & Kevin's Wedding Invitation")
    end
end
