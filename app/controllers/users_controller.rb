# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request!, only: %i[create login]

  def create
    user = User.new(user_params.except(:confirm_password))

    user_params = params[:user]
    if user_params[:password] != user_params[:confirm_password]
      render json: { errors: 'Passwords don\'t match' }, status: :bad_request
    elsif user.save
      Profile.new(profile_params(user)).save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user&.authenticate(params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Invalid username / password' }, status: :unauthorized
    end
  end

  private

  def profile_params(user)
    {
      user_id: user.id,
      bio: 'Set bio',
      avatar: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fassets.materialup.com%2Fuploads%2Fe0b1e16e-e0b7-4328-a1bc-72e1b0b973f6%2Fpreview.png&imgrefurl=https%3A%2F%2Fwww.uplabs.com%2Fposts%2Favatar-2&docid=M8jBzQCDNmLF5M&tbnid=_S739bUwbv7QFM%3A&vet=10ahUKEwjmyLrVgfHmAhW18uAKHVNzDDwQMwjLASgmMCY..i&w=800&h=600&bih=969&biw=1920&q=avatar%20images&ved=0ahUKEwjmyLrVgfHmAhW18uAKHVNzDDwQMwjLASgmMCY&iact=mrc&uact=8'
    }
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :confirm_password)
  end
end
