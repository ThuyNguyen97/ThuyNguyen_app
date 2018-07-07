class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :find_user, only: %i(show edit update destroy)
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if user.save
      user.send_activation_email
      flash[:info] = t ".check"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to user
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = t ".success"
    redirect_to users_path
  end

  def logged_in_user
    return false if logged_in?
    store_location
    flash[:danger] = t ".danger"
    redirect_to login_path
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_path) unless current_user? @user
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  private

  attr_reader :user

  def user_params
    params.required(:user).permit User::USER_ATTRS
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    redirect_to root_path
  end
end
