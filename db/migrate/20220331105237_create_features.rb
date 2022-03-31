class CreateFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :features do |t|
      t.string :feature_name
      t.integer :status
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
