class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.mail string , null: false
      t.presence bollean , null: true
      t.uniqueness bollean , null: true
      t.timestamps
    end
  end
end
