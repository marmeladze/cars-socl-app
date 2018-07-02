class DreamGaragesController < ApplicationController

  def create
    if dream_garage.motors << motor
      flash.now[:notice] = "#{motor.name} added to your dream garage successfully"
    else
      flash.now[:alert] = "Unable to add #{motor.name} to your dream garage"
    end
    redirect_to motor_path(motor)
  end

  def destroy
    dream_garage.motors.delete(motor)
    flash.now[:notice] = "#{motor.name} removed from your dream garage successfully"
    redirect_to motor_path(motor)
  end

  private
  def dream_garage
    current_user.dream_garage
  end

  def motor
    Motor.find(id: params.require(:motor_id), :user_id.ne => current_user.id)
  end
end
