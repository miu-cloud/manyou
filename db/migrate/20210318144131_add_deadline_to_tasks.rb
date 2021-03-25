class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime
    Task.update_all(deadline: Date.today)
    change_column_null :tasks, :deadline, false
  end
end
