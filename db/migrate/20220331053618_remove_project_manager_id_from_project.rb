class RemoveProjectManagerIdFromProject < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :project_manager_id, :integer
  end
end
