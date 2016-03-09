class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :date
      t.string :todo

      t.timestamps null: false
    end
  end
end
