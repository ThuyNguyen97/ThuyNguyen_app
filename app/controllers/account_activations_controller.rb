class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]

    if user && !user.activated?
      authenticated_user user
    else
      flash[:danger] = t "unactived"
      redirect_to root_url
    end
  end

  private

  def authenticated_user user
    return unless user.authenticated? :activation, params[:id]
    user.activate
    log_in user
    flash[:success] = t "actived"
    redirect_to user
  end
end
