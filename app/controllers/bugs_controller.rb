# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_project
  before_action :set_bug, only: %i[show edit update destroy]

  # GET projects/1/bugs
  def index
    @bugs = if current_user.role == 'project_manager' || current_user.role == 'admin' || current_user.role == 'qa'
              @project.bugs
            else
              policy_scope(Bug.all)
            end
  end

  # GET projects/1/bugs/1
  def show; end

  # GET projects/1/bugs/new
  def new
    @status = []
    @status.push('created')
    @users = @project.users.where(role: 'developer')
    @bug = @project.bugs.build
  end

  # GET projects/1/bugs/1/edit
  def edit
    @status = []
    @status.push(@bug.status)
    case current_user.role
    when 'qa'
      case @bug.status
      when 'fixed'
        @status.push('created')
      when 'in_review'
        @status.push('fixed')
      when 'created'
      end
    when 'developer'
      @status.push('in_review') if @bug.status == 'in_progress'
      if @bug.status == 'in_review'
      else
        @status.push('in_review')
      end
    end
    @users = @project.users.where(role: 'developer')
  end

  # POST projects/1/bugs
  def create
    @bug = @project.bugs.build(bug_params)
    if @bug.save
      redirect_to([@bug.project, @bug], notice: 'Bug was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT projects/1/bugs/1
  def update
    if @bug.update(bug_params)
      redirect_to([@bug.project, @bug], notice: 'Bug was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/bugs/1
  def destroy
    @bug.destroy
    redirect_to project_bugs_url(@project)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_bug
      @bug = @project.bugs.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bug_params
      params.require(:bug).permit(:bug_name, :detail, :status, :project_id, :user_id)
    end
end
