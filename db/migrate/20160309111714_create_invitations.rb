class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :token

      t.timestamps null: false
    end
  end
end
