class CreatePlantsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :description
      t.string :user_id
    end
  end
end
