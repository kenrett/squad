class OrderController < ApplicationController

  # /api/v1/user/1/squadrun
  def index
    uri = URI('https://sandbox-api.uber.com/v1/requests/current')
    data = {token: session[:access_token]}

    uri.query = URI.encode_www_form(data)
    @response = Net::HTTP.get(uri).to_json
byebug
    respond_to do |format|
      format.json {render json: @response}
    end
  end
end