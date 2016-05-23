class InviteMailer < ApplicationMailer
  default from: 'weddingsquadnotifications@gmail.com'

  def new_user_invite(invite, sign_up_path)
    @invite = invite
    @url  = sign_up_path
    @recipient = @invite.recipient
    @sender = @invite.sender
    mail(to: @invite.email, subject: '#{@invite.sender.first_name} to My Awesome Site')
  end
end
