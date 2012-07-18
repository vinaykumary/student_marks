class MarksController < ApplicationController

  helper_method :sort_column, :sort_direction

  def edit_marks
    if params[:section].nil?
      @section='A'
    else
      @section=params[:section]
    end
    @exam=Exam.find(params[:exam])
    @subject=Subject.find(params[:subject])
    @marks=Mark.find(:all,:joins=>[:student],:conditions=>["exam_id=#{@exam.id} AND subject_id=#{@subject.id} AND students.section='#{@section}'"],:order=>"roll_no")
  end

  def update
    @marks=params[:mark]
#    puts "**********     DEBUGGING    ***********"
#    puts @marks
    for mark in @marks
      result=Result.find_by_student_id_and_exam_id(mark[1][:student_id],params[:exam])


      if(mark[1][:marks].to_i >=50)
        @marks[mark[0]]["result"]="P"
      elsif(mark[1][:marks].to_i ==-1)
        @marks[mark[0]]["result"]="A"
        if(result.result!="F")
          result.result="A"
#          if result.no_failed.nil?
#            result.no_failed=1
#          else
#            result.no_failed+=1
#          end
        end
      else
         @marks[mark[0]]["result"]="F"
         result.result="F"
          if result.no_failed.nil?
            result.no_failed=1
          else
            result.no_failed+=1
          end
      end
      if result.total.nil?
        result.total=mark[1][:marks].to_i
      else
        result.total+=mark[1][:marks].to_i
      end
      result.percentage=((result.total.to_f/600).to_f*100).to_f.round(2)
      result.save
    end
    Mark.update(@marks.keys,@marks.values)
    redirect_to :controller=>'exams', :action=>'exam_subs', :id=>params[:exam]
  end

  def display_marks
    @exam=Exam.find(params[:id])
    @subjects=Subject.where(:semester=>@exam.semester,:department_id=>@exam.department_id).order("subject_code")
  end

  def view_marks
    conditions=""
    @exam=Exam.find(params[:exam])
    @subject=Subject.find(params[:subject])
    @section=nil
    if params[:section].nil?
        conditions="exam_id=#{@exam.id} AND subject_id=#{@subject.id}"
      else
        @section=params[:section]
        conditions="exam_id=#{@exam.id} AND subject_id=#{@subject.id} AND students.section='#{@section}'"
      end

      @marks=Mark.find(:all,:joins=>[:student],:conditions=>["#{conditions}"],:order=>sort_column+" "+sort_direction)
  end





 def sort_column
    params[:sort] ||="name"
  end

  def sort_direction
    params[:direction] ||="asc"
  end
end
