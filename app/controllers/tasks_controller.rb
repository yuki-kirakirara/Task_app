class TasksController < ApplicationController
   #before_action :set_task, only: [:show, :edit, :update, :destroy]
   before_action :require_user_logged_in, only: [:index, :show]
   before_action :correct_user, only: [:show, :edit, :destroy, :update]
  
    def index
       #if logged_in?
      #@task= current_user.tasks.build  # form_with 用
      @tasks= current_user.tasks.order(id: :desc).page(params[:page]).per(10)
       #end
    end
   
    def show
    end
    
    def new
      @task = Task.new
    end
    
    def create
      @task = Task.new(task_params)
      
       @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = 'タスクが投稿されました'
        redirect_to @task
      else
         #@tasks = current_user.tasks.order(id: :desc).page(params[:page])
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
    
    #def set_task
      #@task = Task.find(params[:id])
    #end
    
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
