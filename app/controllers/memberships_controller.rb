class MembershipsController < ApplicationController
  before_action do
    @user_group = UserGroup.find(params[:user_group_id])
  end

  def index
    @memberships = @user_group.memberships.all
    @membership = @user_group.memberships.new
  end

  def new
    @membership = @user_group.memberships.new
  end

  def create
  @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to user_group_memberships_path(@user_group), notice: "Member successfully saved."
    else
      redirect_to user_group_memberships_path(@user_group), alert: @membership.errors.full_messages
    end
  end

  private
  def membership_params
    params.require(:membership).permit(
      :user_group_id,
      :user_id,
      :membership_type
    )
  end
end
