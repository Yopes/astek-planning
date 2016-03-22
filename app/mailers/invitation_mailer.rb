class InvitationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def invitation_mailer(invitation)
    @invitation = invitation
    mail(to: @invitation.mail, subject: 'Invitation to the Astek planning')
  end
end
