class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
      if params[:title].present?
         @tasks = Task.title(params[:title])
      elsif params[:state].present?
         @tasks = Task.state(params[:state])
      elsif
        @tasks = Task.all.order(created_at: :desc)
      end

      if params[:sort_expired]
        @tasks = Task.all.order(deadline: :asc)
      else
        @tasks = Task.all.order(created_at: :desc)
      end 

      if params[:sort_expired_priority]
        @tasks = Task.all.order(priority: :desc)
      else
        @tasks = Task.all.order(created_at: :desc)
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
