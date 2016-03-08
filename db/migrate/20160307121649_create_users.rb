class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mail
      t.string :login
      t.string :firstname
      t.string :lastname
      t.string :tel
      t.string :promo
      t.boolean :actif
      t.boolean :created

      t.timestamps null: false
    end
    add_index :users, :id
  end
end
