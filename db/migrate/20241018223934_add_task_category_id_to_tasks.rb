class AddTaskCategoryIdToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :task_category_id, :integer
  end
end
