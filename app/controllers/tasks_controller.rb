class TasksController < ApplicationController
    def index
      @incomplete_tasks = Task.where(status: 'incomplete')  # ดึงเฉพาะงานที่ยังไม่เสร็จ
      @complete_tasks = Task.where(status: 'complete')      # ดึงเฉพาะงานที่เสร็จแล้ว
      @task = Task.new  # เตรียมงานใหม่สำหรับฟอร์ม
    end
  
    def create
      @task = Task.new(task_params)
      @task.status = 'incomplete'  # ตั้งสถานะเป็น "ไม่เสร็จ"
  
      if @task.save
        redirect_to tasks_path, notice: 'Task was successfully created.'
      else
        render :index
      end
    end
  
    def complete
      @task = Task.find(params[:id])
      @task.update(status: 'complete')  # อัปเดตสถานะเป็น "เสร็จแล้ว"
      redirect_to tasks_path, notice: 'Task marked as complete.'
    end
    
    def destroy
      @task = Task.find(params[:id])
      @task.destroy  # ลบงาน
  
      redirect_to tasks_path, notice: 'Task was successfully deleted.'  # แจ้งเตือนการลบงานสำเร็จ
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title)
    end
  end
  