class UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def index
    @users = User.search(name_cont: params[:keyword]).result
    render partial: 'users' if request.xhr?
    # 1行でおさまっているので、見た目はいいんですが、respond_to で js or html かで分けたほうがRailsの書き方っぽいので好きです。
  end

  def show
  end

  def set_user
    @user = User.find(params[:id])
  end
end
