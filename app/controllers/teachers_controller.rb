class TeachersController < ApplicationController
 before_action :set_teacher, only: [:show, :edit, :update, :destroy]

    def index
        @teachers=Teacher.all
    end
    
    def edit
     if current_user && current_user.sabancimail != nil
      if Muzikususers.where("email = ?", current_user.sabancimail).count > 0
         if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
          end
        end

    else
      redirect_to teachers_path
        end  
      end
      
      def  new
          if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
            @teacher = Teacher.new
        else
      redirect_to teachers_path
    end
    end

        def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to teachers_path}
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def update
    respond_to do |format|
        if @teacher.update(teacher_params)
            format.html {redirect_to teachers_path}
        else
        format.html { render action: 'edit'}
    end
    end
end

def destroy
 @teacher.destroy
    respond_to do |format|
    format.html {redirect_to teachers_url}
     end
end
  def set_teacher
    @teacher=Teacher.find(params[:id])  
 end

 def teacher_params
     params.require(:teacher).permit(:full_name,:photo,:instrument,:bio,:website)
     end


end
