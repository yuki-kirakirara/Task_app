class TasksController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:show, :edit, :destroy, :update]
  
    def index
      @tasks= current_user.tasks.order(id: :desc)
    end
    def show
    end
    
    def new
      @task = Task.new
    end
    
    def create
      @task = Task.new(task_params)
      
      if @task.save
        flash[:success] = 'タスクが投稿されました'
        redirect_to @task
      else
        flash.now[:danger] = 'タスク投稿がされませんでした'
        render :new
      end
    end
    
    def edit
    end
    
    def update
      if @task.update(task_params)
        flash[:success] = 'タスクが編集されました'
        redirect_to @task
      else
        flash.now[:danger] = 'タスクが編集されませんでした'
        render :edit
      end
    end
  
  
    def destroy
      @task.destroy
      flash[:success] = 'タスクが削除されました'
      redirect_to @task
    end
  
  
    
    private
    
    def task_params
     params.require(:task).permit(:content, :status)
    end
    
    def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
      unless @task
      redirect_to root_url
      end
    end
end
