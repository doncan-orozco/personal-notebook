class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, index: {unique: true}, null: false
      t.string :full_name, null: false
      t.string :username, index: true, null: false
      t.string :bio

      t.timestamps
    end
  end
end
