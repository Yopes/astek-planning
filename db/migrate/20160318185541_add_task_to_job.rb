class AddTaskToJob < ActiveRecord::Migration
  def change
    add_reference :jobs, :task, index: true
  end
end
