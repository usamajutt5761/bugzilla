# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all if user.admin?
    end
  end

  # def show?
  #   # @user.id == @project.project_manager_id
  # end
  def index?
    @user.role == 'admin'
  end

  def new?
    @user.role == 'project_manager' || @user.role == 'admin'
  end
end
