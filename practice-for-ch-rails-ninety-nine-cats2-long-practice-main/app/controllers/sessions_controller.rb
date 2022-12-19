class SessionsController < ApplicationController
  # @user = User.find_by_credential(params[:user][:username], params[:user])
  def new
    @user = User.new
    render :new
  end

  def create
  end

  def destroy
    if logged_in?
      logout!
    end
    redirect_to new_session_url

  end

end
