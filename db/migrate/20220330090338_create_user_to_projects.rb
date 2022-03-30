class CreateUserToProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :user_to_projects do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
