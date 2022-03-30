class ProjectsController < InheritedResources::Base

  private

    def project_params
      params.require(:project).permit(:title, :project_manager_id)
    end

end
