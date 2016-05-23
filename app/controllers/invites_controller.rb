class InvitesController < ApplicationController
  def create
    @invite = Invite.create(invite_params)
    @invite.sender_id = current_user.id
    if @invite.save
      InviteMailer.new_user_invite(@invite, signup_path(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
      redirect_to user_groups_path
    else
      flash[:error] = "sending invite failed"
      redirect_to user_group_path(@invite.user_group_id)
    end
  end

  private
  def invite_params
    params.require(:invite).permit(:email, :user_group_id)
  end
end
