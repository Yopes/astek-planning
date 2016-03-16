class AddDayToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_days, :integer
    add_column :users, :past_days, :integer
  end
end
