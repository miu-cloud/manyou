class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    PER=10

    def index
      # タイトルとステータス両方を絞り込む
      if params[:title].present? && params[:state].present?
         @tasks = Task.page(params[:page]).title_search(params[:title]).state_search(params[:state]).per(PER)
      # もしタイトルしか入力されない場合
      elsif params[:title].present?
         @tasks=Task.page(params[:page]).title_search(params[:title]).per(PER)
      # もしステータスしか入力されない場合   
      elsif params[:state].present?
         @tasks = Task.page(params[:page]).state_search(params[:state]).per(PER)
      # それ以外の場合、一覧画面へ（登録日時：降順）
      else
         @tasks = Task.page(params[:page]).order(created_at: :desc).per(PER)
      end

      if params[:sort_expired]
        @tasks = Task.page(params[:page]).order(deadline: :asc).per(PER)
      end 

      if params[:sort_expired_priority]
        @tasks = Task.page(params[:page]).order(priority: :desc).per(PER)
      end 
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.create(task_params)
        if @task.save
            redirect_to tasks_path, notice: "タスクを作成しました"
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @task.update(task_params)
          redirect_to tasks_path, notice: "タスクを編集しました！"
        else
          render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice:"タスクを削除しました！"
    end

    private
    def task_params
      params.require(:task).permit(:title, :content, :deadline, :state, :priority)
    end

    def set_task
      @task = Task.find(params[:id])
    end

 
end
