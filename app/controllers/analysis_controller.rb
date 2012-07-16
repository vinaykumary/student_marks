class AnalysisController < ApplicationController

  before_filter :index
  $exam=nil
  $subjects=nil
  $department=nil
  $semester=nil
  $year=nil
  $year_map={1=>"I",2=>"II",3=>"III",4=>"IV"}

  def index
    $exam=Exam.find(params[:id])

    $subjects=Subject.where(:department_id=>$exam.department_id,:semester=>$exam.semester).order("subject_code")
    $department=$exam.department
    $semester=$exam.semester
    $year=(($exam.semester.to_f/2.to_f).ceil).to_i

    @exam=$exam
    @department=$department
    @semester=$semester
    @year=$year
    @year_map=$year_map
    @subjects=$subjects

    results=Result.where(:exam_id=>@exam.id,:section=>"A").order("total desc")
    rank=1
    results.each do |result|
      if result.result=="P"
        result.rank=rank
        rank+=1
      end
      #result.percentage=((result.total.to_f/600).to_f*100).to_f.round(2)
      result.save
    end
    results=Result.where(:exam_id=>@exam.id,:section=>"B").order("total desc")
    rank=1
    results.each do |result|
      if result.result=="P"
        result.rank=rank
        rank+=1
      end
      #result.percentage=((result.total.to_f/600).to_f*100).to_f.round(2)
      result.save
    end

  end

  def mark_list
    @exam=Exam.find(params[:id])
    @department=@exam.department
    @semester=@exam.semester
    @year=((@exam.semester.to_f/2.to_f).ceil).to_i
    @year_map={1=>"I",2=>"II",3=>"III",4=>"IV"}
    @subjects=Subject.where(:department_id=>@exam.department_id,:semester=>@exam.semester).order("subject_code")

    @students=Student.find(:all,:conditions=>{:department_id=>@department.id,:semester=>@semester,:section=>@section},:order=>"roll_no")
    @marks=Hash.new
    for student in @students
      @marks[student.id]=Mark.find(:all,:joins=>[:subject],:conditions=>{:student_id=>student.id,:exam_id=>@exam.id},:order=>'subject_code')
    end
    #@subjects=Subject.where(:department_id=>@department.id,:semester=>@semester).order("subject_code")

    @results=Result.where(:exam_id=>@exam.id,:section=>@section).order("total desc")
    rank=1
    @results.each do |result|
      if result.result=="P"
        result.rank=rank
        rank+=1
      end
      #result.percentage=((result.total.to_f/600).to_f*100).to_f.round(2)
      result.save
    end
  end

  def indiv_sub_fail
    @exam=Exam.find(params[:id])
    @department=@exam.department
    @semester=@exam.semester
    @year=((@exam.semester.to_f/2.to_f).ceil).to_i
    @year_map={1=>"I",2=>"II",3=>"III",4=>"IV"}
    @subjects=Subject.where(:department_id=>@exam.department_id,:semester=>@exam.semester).order("subject_code")
    @subject=Subject.find(params[:sub])

#    @results=Result.find(:all,:conditions=>["exam_id=#{@exam.id} and result!='P'"],:joins=>[:student],:order=>'roll_no')

  @marks=Mark.find(:all,:conditions=>["exam_id=#{@exam.id} and subject_id=#{@subject.id} and result!='P'"],:joins=>[:student],:order=>'roll_no')

    @no_absent=0
    @no_fail=0
    for mark in @marks
      if mark.result=="F"
        @no_fail+=1
      elsif mark.result=="A"
        @no_absent+=1
      end
    end
  end

  def no_sub_fail
    @exam=Exam.find(params[:id])
    @department=@exam.department
    @semester=@exam.semester
    @year=((@exam.semester.to_f/2.to_f).ceil).to_i
    @year_map={1=>"I",2=>"II",3=>"III",4=>"IV"}


    @single_sub_f=0
    @two_sub_f=0
    @gt_three_f=0

    @sing_sub_marks=Hash.new
    @two_sub_marks=Hash.new
    @gt_three_sub_marks=Hash.new

    #one Subject Failures
    @single_sub_studs=Student.find(:all,:conditions=>["results.exam_id=32 and results.no_failed=1"],:joins=>[:results],:order=>'roll_no')
    @single_sub_f=@single_sub_studs.count

    for student in @single_sub_studs
      @sing_sub_marks[student.id]=Mark.find(:all,:joins=>[:subject],:conditions=>{:student_id=>student.id,:exam_id=>@exam.id},:order=>'subject_code')
    end


    #two Subject Failures
    @two_sub_studs=Student.find(:all,:conditions=>["results.exam_id=32 and results.no_failed=2"],:joins=>[:results],:order=>'roll_no')
    @two_sub_f=@two_sub_studs.count

    for student in @two_sub_studs
      @two_sub_marks[student.id]=Mark.find(:all,:joins=>[:subject],:conditions=>{:student_id=>student.id,:exam_id=>@exam.id},:order=>'subject_code')
    end


    #one Subject Failures
    @gt_three_sub_studs=Student.find(:all,:conditions=>["results.exam_id=32 and results.no_failed>=3"],:joins=>[:results],:order=>'roll_no')
    @gt_three_f=@gt_three_sub_studs.count
    for student in @gt_three_sub_studs
      @gt_three_sub_marks[student.id]=Mark.find(:all,:joins=>[:subject],:conditions=>{:student_id=>student.id,:exam_id=>@exam.id},:order=>'subject_code')
    end

    @subjects=Subject.where(:department_id=>@department.id,:semester=>@semester).order("subject_code")

  end

  def fail_summary
    @exam=Exam.find(params[:id])
    @department=@exam.department
    @semester=@exam.semester
    @year=((@exam.semester.to_f/2.to_f).ceil).to_i
    @year_map={1=>"I",2=>"II",3=>"III",4=>"IV"}
    @subjects=Subject.where(:department_id=>@exam.department_id,:semester=>@exam.semester).order("subject_code")

    @single_sub_f=Result.where("no_failed=1 and exam_id=32").count()
    @two_sub_f=Result.where("no_failed=2 and exam_id=32").count()
    @gt_three_f=Result.where("no_failed>=3 and exam_id=32").count()
    @abs=Result.where("no_failed=0 and result='A' and exam_id=32").count()

    @total_students=Student.where("department_id=#{@department.id} and semester=#{@semester}").count()
  end

  def result_analysis
    @exam=Exam.find(params[:id])
    @department=@exam.department
    @semester=@exam.semester
    @year=((@exam.semester.to_f/2.to_f).ceil).to_i
    @year_map={1=>"I",2=>"II",3=>"III",4=>"IV"}
    @subjects=Subject.where(:department_id=>@exam.department_id,:semester=>@exam.semester).order("subject_code")

    @analysis_data=Array.new
    @total_pass=0
    @total_students=Student.where("department_id=#{@department.id} and semester=#{@semester}").count()

    for subject in @subjects
      present=Mark.where("exam_id=#{@exam.id} and subject_id=#{subject.id} and result!='A'").count()
      absent=Mark.where("exam_id=#{@exam.id} and subject_id=#{subject.id} and result='A'").count()
      passed=Mark.where("exam_id=#{@exam.id} and subject_id=#{subject.id} and result='P'").count()
      failed=Mark.where("exam_id=#{@exam.id} and subject_id=#{subject.id} and result='F'").count()
      total_students=Mark.where("exam_id=#{@exam.id} and subject_id=#{subject.id}").count()
      pass_percent=((passed.to_f/total_students.to_f)*100).to_f.round(2)
      @total_pass+=passed
      @analysis_data<<{subject.id => {
                                        :present=>present,
                                        :absent=>absent,
                                        :passed=>passed,
                                        :failed=>failed,
                                        :total=>total_students,
                                        :pass_percent=>pass_percent
                                      }
                      }

    end

    @pass_percent_ovr=((@total_pass.to_f/@total_students.to_f)*100).to_f.round(2)

    @Asec_ranks=Array.new
    @Bsec_ranks=Array.new

    3.times do |i|
      @Asec_ranks << Result.where("exam_id=#{@exam.id} and section='A' and rank=#{i+1}")
      @Bsec_ranks << Result.where("exam_id=#{@exam.id} and section='B' and rank=#{i+1}")
    end


#    puts @analysis_data

  end


end
