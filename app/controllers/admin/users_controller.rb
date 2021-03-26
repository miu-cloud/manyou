class Admin::UsersController < ApplicationController
  def new
  end

  def index
    @users = User.all
  end
 
  def edit
    @user = User.find(user.id)
  end

end
