class StudentsController < ApplicationController

  helper_method :sort_column, :sort_direction
  def index
    @departments=Department.all
  end

  def list
    @department_name=Department.find(params[:dept]).name
    @department_id=params[:dept]
    @semester=params[:semester]
    @students=Student.where(:department_id=>params[:dept],:semester=>params[:semester]).order(sort_column+" "+sort_direction)
  end

  def show
    @student=Student.find(params[:id])
    @results=Result.where("student_id=#{params[:id]}")
    @exams=Array.new
    for result in @results
      @exams << Exam.find(result.exam_id)
    end
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

  def view_marks
    @student=Student.find(params[:id])
    @exam=Exam.find(params[:exam])
    @result=Result.where(:exam_id=>@exam.id,:student_id=>@student.id)[0]
    @marks=Mark.find(:all,:joins=>[:subject],:conditions=>["exam_id=#{@exam.id} and student_id=#{@student.id}"],:order=>'subject_code')
    @subjects=Subject.where("department_id=#{@student.department.id} and semester=#{@student.semester}").order('subject_code')
  end

  def delete
    @student=Student.find(params[:id])
  end


  def destroy
    @student=Student.find(params[:id])
    @department=@student.department
    @semester=@student.semester
    if @student.destroy
      redirect_to :action=>'list',:dept=>@department.id,:semester=>@semester
      flash[:notice]="Student deleted"
    else
      redirect_to :action=>'list',:dept=>@department.id,:semester=>@semester
      flash[:notice]="Error in deleting Student"
    end
  end

  def sort_column
    params[:sort] ||="name"
  end

  def sort_direction
    params[:direction] ||="asc"
  end

end
