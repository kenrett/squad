class SquadsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.find(params[:user_id])
    @squad = @user.squads.build
  end

  def create
    @user = User.find(params[:user_id])
    @squad = @user.squads.create(name: params[:name])

    if @squad.save
      flash[:success] = "Squad successfully created."
      redirect_to root_url
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @squad = @user.squads.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @squad = @user.squads.find(params[:id])

    @squad.update_attribute(:name, params[:squad][:name])

    if @squad.save
      flash[:success] = "Squad name updated!"
      redirect_to root_url
    end
  end

  private

  def squad_params
    params.require(:squad).permit(:name)
  end
end
