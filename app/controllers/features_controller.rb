class FeaturesController < ApplicationController
  before_action :set_project
  before_action :set_feature, only: [:show, :edit, :update, :destroy]

  # GET projects/1/features
  def index
    @features = @project.features
  end

  # GET projects/1/features/1
  def show
  end

  # GET projects/1/features/new
  def new
    
    @status = []
    @status.push("created")
    @feature = @project.features.build
    authorize @feature
    # @project = @project
    # puts("start")
    # @project_name = @project.name
    # puts(@project_name)
  end

  # GET projects/1/features/1/edit
  def edit
    @status = []
    @status.push(@feature.status)

    
    if current_user.role == "qa"
      if(@feature.status == "complete")
        @status.push("created")
      elsif(@feature.status == "in_progress")
        @status.push("complete")
      end

    elsif current_user.role == "developer"
      if(@feature.status == "in_progress" || @feature.status == "complete")
      else
        @status.push("in_progress")
      end
      
    end
    
  end

  # POST projects/1/features
  def create
    @feature = @project.features.build(feature_params)

    if @feature.save
      redirect_to([@feature.project, @feature], notice: 'Feature was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT projects/1/features/1
  def update
    if @feature.update(feature_params)
      redirect_to([@feature.project, @feature], notice: 'Feature was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/features/1
  def destroy
    @feature.destroy

    redirect_to project_features_url(@project)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_feature
      @feature = @project.features.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feature_params
      params.require(:feature).permit(:feature_name, :status, :project_id)
    end
end