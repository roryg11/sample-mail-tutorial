class UserGroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]
  as_json include: :users

  # GET /user_groups
  # GET /user_groups.json
  def index
    @user_groups = UserGroup.all
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
    @invite = Invite.new
    @user_group = UserGroup.find(params[:id])
  end

  # GET /user_groups/new
  def new
    @user_group = UserGroup.new
  end

  # GET /user_groups/1/edit
  def edit
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    @user_group = UserGroup.new(user_group_params)
    respond_to do |format|
      if @user_group.save
        @owner_membership = @user_group.memberships.new()
        @owner_membership.user_group_id = @user_group.id
        @owner_membership.user_id = current_user.id
        @owner_membership.membership_type = "owner"
        if @owner_membership.save
          format.html { redirect_to @user_group, notice: 'User group was successfully created.' }
          format.json { render :show, status: :created, location: @user_group }
        else
          format.html { render :new }
          format.json { render json: @owner_membership.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_groups/1
  # PATCH/PUT /user_groups/1.json
  def update
    respond_to do |format|
      if @user_group.update(user_group_params)
        format.html { redirect_to @user_group, notice: 'User group was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_group }
      else
        format.html { render :edit }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    @user_group.destroy
    respond_to do |format|
      format.html { redirect_to user_groups_url, notice: 'User group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name, :hashtag)
    end

    def membership_params
      params.require(:membership).permit(
        :user_group_id,
        :user_id,
        :membership_type
      )
    end
end
