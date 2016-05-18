class OrderController < ApplicationController

  # /api/v1/user/1/squadrun
  def index
    @response = uberify('https://sandbox-api.uber.com/v1/requests/current&scope=request', "GET")
    # respond_to do |format|
    #   format.json {render json: @response}
    # end
  end

  # /api/v1/user/1/squadrun/:id/add_car
  def add_squad_car
    @response = uberify('https://sandbox-api.uber.com/v1/requests?start_latitude=37.780969&start_longitude=-122.406011&end_latitude=37.781446&end_longitude=-122.392154&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d', "POST")
    byebug
    respond_to do |format|
      format.html { redirect_to squadrun_path }
      format.json { render json: @response }
    end
  end

  # /api/v1/user/1/squads/all
  def all_squads
    @user = User.find(params[:id])
    @squads = @user.squads
  end

  def new
  end
end