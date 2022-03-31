class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.string :bug_name
      t.text :detail
      t.integer :status
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
