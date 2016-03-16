class AddPeopleToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :people, :integer
    add_column :tasks, :need, :integer
  end
end
