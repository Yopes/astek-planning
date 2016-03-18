class DeleteUserPastDaysAndTaskPeople < ActiveRecord::Migration
  def change
    remove_column :users, :past_days, :integer
    remove_column :tasks, :people, :integer
  end
end
