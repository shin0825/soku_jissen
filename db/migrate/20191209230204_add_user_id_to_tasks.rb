class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false, index:true
  end

  def down
    remove_reference :tasks, :user, index: true #[知見] 4-5-11
  end
end
