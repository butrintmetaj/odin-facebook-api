class Api::V1::Auth::ProfilesController < ApplicationController

  def show
    render json: { user: @current_user }, status: :ok
  end

  def update
    if @current_user.update(user_params)
      render json: { user: @current_user }, status: :ok
    else
      render json: { message: 'Could not update profile' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :birthday, :gender)
  end
end
