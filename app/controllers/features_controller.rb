# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :set_project
  before_action :set_feature, only: %i[show edit update destroy]

  # GET projects/1/features
  def index
    @features = policy_scope(Feature)
  end

  # GET projects/1/features/1
  def show; end

  # GET projects/1/features/new
  def new
    @status = []
    @status.push('created')
    @feature = @project.features.build
    authorize @feature
  end

  def edit
    @status = []
    @status.push(@feature.status)
    case current_user.role
    when 'qa'
      case @feature.status
      when 'complete'
        @status.push('created')
      when 'in_review'
        @status.push('complete')
      end
    when 'developer'
      @status.push('in_review') if @feature.status == 'in_progress'
      if @feature.status == 'in_review'
      else
        @status.push('in_progress')
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
