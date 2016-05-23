class RegistrationController < ApplicationController
  def new
    @token = params[:invite_token] #<-- pulls the value from the url query string
    @user = User.new
  end

  def create
    @newUser = User.new(user_params)
    @newUser.save
    @token = params[:invite_token]
    if @token != nil
       org =  Invite.find_by_token(@token).user_group #find the user group attached to the invite
       @newUser.user_groups.push(org) #add this user to the new user group as a member
       redirect_to users_path
    else
      if @user.save
        redirect_to users_path
      else
        render :new
        flash[:alert]= "User could not be signed up"
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
