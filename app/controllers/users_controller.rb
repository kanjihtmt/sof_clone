class UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def index
    @users = User.search(name_cont: params[:keyword]).result
    render partial: 'users' if request.xhr?
  end

  def show
  end

  def set_user
    @user = User.find(params[:id])
  end
end