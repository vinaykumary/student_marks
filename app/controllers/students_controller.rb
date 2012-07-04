class StudentsController < ApplicationController

  helper_method :sort_column, :sort_direction
  def index
    @departments=Department.all
  end

  def list
    @department_name=Department.find(params[:dept]).name
    @department_id=params[:dept]
    @semester=params[:semester]
    @students=Student.order(sort_column+" "+sort_direction).paginate(:per_page=> 5,:page=>params[:page])
  end

  def show
    @student=Student.find(params[:id])
  end

  def new
    @student=Student.new
  end

  def create
    @student=Student.new(params[:student])
    if @student.save
      render('new')
      flash[:notice]="New Student added"
    else
      render('new')
      flash[:notice]="Error in Adding Student"
    end
  end



  def sort_column
    params[:sort] ||="name"
  end

  def sort_direction
    params[:direction] ||="asc"
  end

end
