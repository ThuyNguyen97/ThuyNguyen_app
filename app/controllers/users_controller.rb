class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.required(:user).permit User::USER_ATTRS
  end
end