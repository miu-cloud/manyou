class Admin::UsersController < ApplicationController
  before_action :admin_user

  def new
    @user = User.new
  end

  def index
    @users = User.select(:id, :name, :created_at, :admin)
    # @users = User.all.includes(:user)
  end

  def create
    @user = User.new(user_params)
    if User.where(email: @user.email).count >= 1
      flash[:notice] = '既に登録されているメールアドレスです'
      render :new
    elsif @user.save
      redirect_to admin_users_path, notice: 'ユーザーを登録しました'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザーを編集しました！'
    else
      render :edit
    end
  end
 
 
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザーを削除しました！"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
  end
  def admin_user
    redirect_to tasks_path, notice:"権限がありません！管理者のみアクセス可能です" unless current_user.admin?
  end
end
