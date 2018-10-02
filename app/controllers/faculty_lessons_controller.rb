class FacultyLessonsController < ApplicationController
    before_action :set_rights

    def index
    end

    def show
    end

    def edit
    end

    def create
    end

    def update
    end

    def destroy
    end

    private
        def faculty_lesson_params
            params.require(:faculty_lesson).permit(:teacher_id, :name)
        end

        def set_rights
            if current_user && current_user.is_member
                if not current_user.is_myk
                    redirect_to root_path
                end
            else
                redirect_to root_path
            end
        end
end