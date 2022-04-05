class ProjectsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]






  def index
    
  #  @project = Projects.find_by id:current_user
    if current_user.role == 'admin'
      @projects = Project.all
      # @users  = Project.users
    else  
    
     @projects = current_user.projects
    
    
    #  @users  = @projects.users
    end
  end

  def show 
    @users = @project.users
    @features = @project.features
    @bugs = @project.bugs
  end

  def new
   if current_user.role =='project_manager' || current_user.role == 'admin'
     @project = Project.new
     @users = User.all
     @users = User.where.not(id:current_user.id)
     @added_users = false
     authorize @project
     
     if not user_signed_in?
       redirect_to user_session_path, :notice => 'login to continue'
     end
   else
      redirect_to user_session_path, notice: 'You are not autthorized to create the Project'
   end 
  end  


  def edit
    # puts("start")
    # puts(@project.name)
    @added_users = @project.users

    # puts(@added_users)
    @users = User.all
  end
  def create
    if current_user.role =='project_manager'
     @project = Project.new(project_params)
     puts("start")

     # users = params[:users]

     # users.each do |user|
     #   add_user = User.find_by id: user
     #   puts(add_user.email)
     # end

     # add_user = User.find_by id: users[2]
     # puts(add_user.email)


     respond_to do |format|
       if @project.save
         saved_project = Project.find_by id: @project.id
         users = params[:users]
         saved_project.users.push(current_user)

         users.each do |user|
           add_user = User.find_by id: user
           saved_project.users.push(add_user)
           # puts(add_user.email)
         end


         puts(saved_project.title)
         format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
         format.json { render :show, status: :created, location: @project }
       else
         format.html { render :new, status: :unprocessable_entity }
         format.json { render json: @project.errors, status: :unprocessable_entity }
       end
     end
    else
      format.html { redirect_to project_url(@project), notice: "You are not autthorized to create the Project" }
    end
  end


  def update
    respond_to do |format|
      
      users = params[:users]
      saved_project = @project
      ids_array = saved_project.users.ids
      x = []
      users.each do |user|
        x.push(user.to_i)
      end
      ids_array.each do |id_|
        puts(x.include?(id_))
      end
      ids_array.each do |id_|
        if !(x.include?(id_))
          y = UserToProject.where(project_id: saved_project.id, user_id: id_)
          y.delete_all
          # user_delete = saved_project.users.find_by id:id_
          # user_delete.delete
        end
      end

      users.each do |user|
        # puts(ids_array.include?(user.to_i))
        if !(ids_array.include?(user.to_i))
          add_user = User.find_by id: user
          saved_project.users.push(add_user)
        end

      end

      

      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
   @project.destroy
    respond_to do |format|
     format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
     format.json { head :no_content }
    end
  end

 private

  def project_params
   params.require(:project).permit(:title)
  end

    # Use callbacks to share common setup or constraints between actions.
  def set_project
   @project = Project.find(params[:id])
  end
end
