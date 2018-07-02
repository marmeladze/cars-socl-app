class GroupsController < ApplicationController
  before_action :get_group, only: [:show, :upload_pic, :edit, :update]

  def new
    @group = current_user.groups.build
  end

  def upload_pic
    if @group.update_attributes(group_pic_attrs)
      flash[:success] = "Updated pic successfully"
    else
      flash[:error] = "Failed to update pic"
    end
    redirect_to group_path(@group)
  end

  def create
    puts "*"*100
    puts params
    puts "*"*100
    group = current_user.groups.build(group_attrs)
    if group.save
      flash[:success] = 'Group Created successfully'
      set_current_entity(group)
      redirect_to group_path(group)
    else
      render_with_error(group.errors.full_messages.join(','), 422)
    end
  end

  def edit
    set_current_entity(@group)
  end

  def update
    if @group.update_attributes(group_attrs)
      flash[:success] = "Updated group profile successfully"
      redirect_to group_path(@group)
    else
      flash[:error] = "Failed to update profile"
      puts @group.errors.full_messages
    end
  end

  def show
    set_current_entity(@group)
  end

  private

  def group_attrs
    params.require(:group).permit(:group_type,
      profile_attributes: [:name, :about, :avatar, :cover_pic],
      photos_attributes: [:id, :file, :_destroy],
      categories_attributes: [:name, :make, :model]
    )
  end

  def group_pic_attrs
    params.require(:group).permit(
      profile_attributes: [:cover_pic, :avatar]
    )
  end

  def get_group
    @group ||= current_user.groups.find(params[:id])
  end
end
