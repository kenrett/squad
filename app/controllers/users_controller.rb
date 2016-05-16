require 'net/http'

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def create
    @authorization_code = params[:code]
    @callback_url = 'http://localhost:3000/auth/callback'
    @consumer = OAuth::Consumer.new(
        Rails.application.secrets.uber_client_id,
        Rails.application.secrets.uber_client_secret,
          :site => 'https://login.uber.com/oath/token')
    data = { grant_type: "authorization_code",
             redirect_uri: 'http://localhost:3000/auth/callback',
             code: @authorization_code}

    @request_token = @consumer.get_request_token(:oauth_callback => @callback_url)
byebug
    session[:token] = request_token.token
    session[:token_secret] = request_token.secret
    redirect_to @request_token.authorize_url(:oauth_callback => @callback_url)

    p "*" * 100
    p res

    byebug
    # @user = User.new(user_params)
    # if @user.save
    #   flash[:info] = "You are now logged in."
    #   redirect_to root_url
    # else
    #   render 'new'
    # end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
