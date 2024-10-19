class TasksController < ApplicationController
  def index
    @incomplete_tasks = Task.where(status: 'incomplete')  # ดึงเฉพาะงานที่ยังไม่เสร็จ
    @complete_tasks = Task.where(status: 'complete')      # ดึงเฉพาะงานที่เสร็จแล้ว
    @task = Task.new  # เตรียมงานใหม่สำหรับฟอร์ม
    @task_categories = TaskCategory.all  # ดึงหมวดหมู่ทั้งหมด
    @work_tasks = Task.where(completed: false, task_category_id: work_category_id)
    @personal_category_id = TaskCategory.find_by(name: "Personal")&.id
    @personal_tasks = Task.where(completed: false, task_category_id: personal_category_id) # ดึงรายการหมวดหมู่ทั้งหมดเพื่อใช้ในฟอร์ม
  end
  
  def create
    @task = Task.new(task_params)
    @task.status = 'incomplete'  # ตั้งสถานะเป็น "ไม่เสร็จ"
    @task.completed = false
    @task.task_category_id = params[:task][:task_category_id]  # เชื่อมโยงงานกับหมวดหมู่ที่เลือก

    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      logger.debug @task.errors.full_messages # เพิ่มการตรวจสอบข้อผิดพลาด
      @incomplete_tasks = Task.where(status: 'incomplete')
      @complete_tasks = Task.where(status: 'complete')
      @task_categories = TaskCategory.all
      render :index
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(status: 'complete', completed: true)  # อัปเดตสถานะงานเป็น "เสร็จแล้ว"
    redirect_to tasks_path, notice: 'Task marked as complete.'
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy  # ลบงาน
    redirect_to tasks_path, notice: 'Task was successfully deleted.'  # แจ้งเตือนการลบงานสำเร็จ
  end

  def up
    TaskCategory.create(name: "Work")
  end

  def personal_category_id
    category = TaskCategory.find_by(name: "Personal")
    category ? category.id : nil
  end
  
  private

  def work_category_id
    category = TaskCategory.find_by(name: "Work")
    category ? category.id : nil
  end

  

  def task_params
    params.require(:task).permit(:title, :task_category_id)  # เพิ่ม task_category_id เพื่อรองรับหมวดหมู่
  end
end
