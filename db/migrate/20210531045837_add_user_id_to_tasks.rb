class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user, forign_key: true
  end
end
