class ChangeOptionTitleToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :title, :text, null: false
  end
end
