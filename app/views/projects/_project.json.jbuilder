json.extract! project, :id, :title, :project_manager_id, :created_at, :updated_at
json.url project_url(project, format: :json)
