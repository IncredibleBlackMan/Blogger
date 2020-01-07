# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :find_profile

  def show
    profile = profile_object(@profile)
    render json: { profile: profile }, status: :ok
  end

  def update
    if @profile['user_id'] == @current_user.id
      @profile&.update(profile_params)
      render json: { message: 'Profile successfully updated' }, status: :ok
    else
      render json: {
        message: 'You have to be the owner to update this profile'
      }, status: :forbidden
    end
  end

  private

  def find_profile
    user_id = User.where(username: params[:id]).pluck(:id)[0]
    @profile = Profile.find_by(user_id: user_id)
  rescue StandardError => e
    render json: {
      errors: e.message
    }, status: :bad_request
  end

  def profile_object(profile)
    {
      id: profile.id,
      username: params[:id],
      bio: profile.bio,
      avatar: profile.avatar
    }
  end

  def profile_params
    params.require(:profile).permit(:bio, :avatar)
  end
end
