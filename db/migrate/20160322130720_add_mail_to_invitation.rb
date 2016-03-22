class AddMailToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :mail, :string
  end
end
