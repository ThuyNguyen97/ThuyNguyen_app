class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user,
    :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if user
      user.create_reset_digest
      user.send_password_reset_email
      flash[:info] = t "info"
      redirect_to root_url
    else
      flash.now[:danger] = t "not_found"
      render :new
    end
  end

  def edit; end

  def update
    empty? user
    if user.update_attributes user_params
      log_in user
      user.update_attributes reset_digest: nil
      flash[:success] = t "rs_pass"
      redirect_to user
    else
      render :edit
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit User::USER_PASS
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    unless @user&.activated? &&
           @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "exp_pass"
    redirect_to new_password_reset_url
  end

  def empty? user
    return unless params[:user][:password].empty?
    user.errors.add :password, t("not_empty")
    render :edit
  end
end
