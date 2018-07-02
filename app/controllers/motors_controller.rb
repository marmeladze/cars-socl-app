class MotorsController < ApplicationController
  before_action :get_motor, only: [:show, :upload_pic, :edit, :update]

  def new
  end

  def upload_pic
    if @motor.update_attributes(motor_pic_attrs)
      flash[:success] = "Updated pic successfully"
    else
      flash[:error] = "Failed to update pic"
    end
    redirect_to motor_path(@motor)
  end

  def create
    motor = current_user.motors.build(motor_attrs)
    if motor.save
      flash[:success] = 'Motor Created successfully'
      set_current_entity(motor)
      redirect_to motor_path(motor)
    else
      render_with_error(motor.errors.full_messages.join(','), 422)
    end
  end

  def edit
    set_current_entity(@motor)
  end

  def update
    if @motor.update_attributes(motor_attrs)
      flash[:success] = "Updated profile successfully"
    else
      flash[:error] = "Failed to update profile"
    end
    redirect_to motor_path(@motor)
  end

  def show
    set_current_entity(@motor)
  end

  def look_up
    # data = Motor.vehicle_data_lookup(params[:reg_no])
    data = Motor.vehicle_data_lookup
    render json: data.to_json
  end

  private

  def motor_attrs
    params.require(:motor).permit(:motor_category, :reg_no,
      :make, :model, :make_year, :gearbox, :co2_emissions, 
      :trim, :body_type, :engine_size, :top_speed, :mileage,
      :acceleration, :fuel_consumption, :fuel_type,
      profile_attributes: [:name, :about, :avatar, :cover_pic],
      photos_attributes: [:id, :file, :_destroy]
    )
  end

  def motor_pic_attrs
    params.require(:motor).permit(
      profile_attributes: [:cover_pic, :avatar]
    )
  end

  def get_motor
    @motor ||= Motor.find(params[:id])
  end
end
