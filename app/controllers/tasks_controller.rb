class TasksController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:edit, :destroy, :update, :show,]
  
    def index
       @tasks= current_user.tasks.order(id: :desc).page(params[:page]).per(5)
    end
    
    def show
    end
    
    
    def new
      @task = Task.new
    end
    
    
    def create
      @task = current_user.tasks.build(task_params)
      if @task.save(task_params)
        flash[:success] = 'タスクが投稿されました'
        redirect_to root_url
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
        redirect_to root_url
      else
        flash.now[:danger] = 'タスクが編集されませんでした'
        render :edit
      end
   end
  
  
    def destroy
      @task.destroy
      flash[:success] = 'タスクが削除されました'
      redirect_to root_url
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
