class TeachersController < ApplicationController
  def index
  	@teachers = Teacher.all
  	@newTeacher = Teacher.new
  end
end
