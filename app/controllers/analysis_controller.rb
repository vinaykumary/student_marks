class AnalysisController < ApplicationController

  def index
    @exam=Exam.find(params[:id])
  end

  def mark_list
    @exam=Exam.find(params[:id])
    @section=params[:section]
    @department=@exam.department
    @semester=@exam.semester
    @year=((@exam.semester.to_f/2.to_f).ceil).to_i
    @year_map={1=>"I",2=>"II",3=>"III",4=>"IV"}

    @students=Student.find(:all,:conditions=>{:department_id=>@department.id,:semester=>@semester,:section=>@section},:order=>"roll_no")
    @marks=Hash.new
    for student in @students
      @marks[student.id]=Mark.find(:all,:joins=>[:subject],:conditions=>{:student_id=>student.id},:order=>'subject_code')
    end
    @subjects=Subject.where(:department_id=>@department.id,:semester=>@semester).order("subject_code")

    @results=Result.where(:exam_id=>@exam.id,:section=>@section).order("total desc")
    rank=1
    @results.each do |result|
      if result.result=="P"
        result.rank=rank
        rank+=1
      end
      result.percentage=((result.total.to_f/600).to_f*100).to_f.round(2)
      result.save
    end
  end


end
