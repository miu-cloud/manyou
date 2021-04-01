class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  
  private
  def login_required
    unless current_user
      redirect_to new_session_path 
      flash[:notice] = 'ログインして下さい！'
    end 
  end
  #登録をしているユーザであれば新規登録画面にアクセスさせない
  def not_register_new
    if current_user
      redirect_to tasks_path 
    end 
  end
end
