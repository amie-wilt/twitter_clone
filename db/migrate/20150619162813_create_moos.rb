class CreateMoos < ActiveRecord::Migration
  def change
    create_table :moos do |t|
      t.string :description
      t.references :user

      t.timestamps null: false
    end
  end
end
