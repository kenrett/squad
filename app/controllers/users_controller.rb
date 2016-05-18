require 'net/http'
require 'uri'

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def create
    @authorization_code = params[:code]
    uri = URI('https://login.uber.com/oauth/v2/token')
    @redirect_uri = 'https://limitless-island-93047.herokuapp.com/auth/callback'
    data = {client_id: ENV["uber_client_id"],
            client_secret: ENV["uber_client_secret"],
            grant_type: "authorization_code",
            redirect_uri: @redirect_uri,
            code: @authorization_code}

    res = Net::HTTP.post_form(uri, data)
    p ENV["uber_client_id"]
    p "* " * 25
    p ENV["uber_client_secret"]
    @access_token = ActiveSupport::JSON.decode(res.body)['access_token']
    @refresh_token = ActiveSupport::JSON.decode(res.body)['refresh_token']
p "*" * 100
    p @access_token
    get_user_info(@access_token)

    @user = User.find_or_create_by(name: @user_info["first_name"], email: @user_info["email"])
    @user.update_attribute(:refresh_token, @refresh_token)

    if @user.save
      session[:user_id] = @user.id
      session[:refresh_token] = @refresh_token
      flash[:info] = "You are now logged in."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    session.clear
    uri = URI('https://login.uber.com/oauth/revoke')
#
    data = {client_id: ENV["uber_client_id"],
            client_secret: ENV["uber_client_secret"],
            token: @access_token}

    uri.query = URI.encode_www_form(data)
    response = Net::HTTP.get(uri)
    flash[:danger] = "You have been logged out."
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :refresh_token)
  end

  def get_user_info(access_token)
    data = "Bearer #{access_token}"
p "In get_user_info"
    url = URI.parse('https://sandbox-api.uber.com/v1/me')
    # uberify('https://sandbox-api.uber.com/v1/me', "GET")
    req = Net::HTTP::Get.new(url.path)
    req.add_field('Authorization', data)
    session[:access_token] = data

    res = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') do |http|
      http.request(req)
    end
p "&" * 20
    p res.body
    @user_info = JSON.parse(res.body)
  end
end
