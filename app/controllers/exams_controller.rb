class ExamsController < ApplicationController

  def index
    redirect_to :action=>"list"
  end

  def list
    if params[:dept].nil?
      @exams=Exam.order("date DESC")
    else
      @exams=Exam.where(:department_id=>params[:dept]).order("date DESC")
    end
  end

  def new
    @exam=Exam.new
  end

  def create
    @exam=Exam.new(params[:exam])
    @exam.date=build_date_from_params(:date, params[:exam])
    if @exam.save
      @students=Student.where(:semester=>@exam.semester,:department_id=>@exam.department_id)
      @subjects=Subject.where(:semester=>@exam.semester,:department_id=>@exam.department_id).order("subject_code")
      for student in @students
        for subject in @subjects
          mark=Mark.new
            mark.student_id=student.id
            mark.exam_id=@exam.id
            mark.subject_id=subject.id
          mark.save
        end
        result=Result.new
          result.student_id=student.id
          result.exam_id=@exam.id
          result.section=student.section
          result.result="P"
        result.save
      end
      redirect_to :action=>'list',:dept=>@exam.department_id
      flash[:notice]="New Exam added"
    else
      render('new')
      flash[:notice]="Error in Adding Exam"
    end
  end

  def exam_mgmt
    @exam=Exam.find(params[:id])
    @semester=@exam.semester
    @department=@exam.department
  end

  def exam_subs
    @exam=Exam.find(params[:id])
    @subjects=Subject.where(:semester=>@exam.semester,:department_id=>@exam.department_id).order("subject_code")

  end


  # Reconstruct a date object from date_select helper form params
  def build_date_from_params(field_name, params)
    Date.new(params["#{field_name.to_s}(1i)"].to_i,
            params["#{field_name.to_s}(2i)"].to_i,
             params["#{field_name.to_s}(3i)"].to_i)
  end

  def delete
    @exam=Exam.find(params[:id])
  end

  def destroy
    @exam=Exam.find(params[:id])
    Result.destroy_all(["exam_id=#{@exam.id}"])
    Mark.destroy_all(["exam_id=#{@exam.id}"])
    @exam.destroy
    flash[:notice]="Exam Successfully Deleted!"
    redirect_to :action=>'index'
  end

end
