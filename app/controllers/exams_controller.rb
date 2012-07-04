class ExamsController < ApplicationController

  def index
    redirect_to :action=>"list"
  end

  def list
    if params[:dept].nil?
      @exams=Exam.all
    else
      @exams=Exam.where(:department_id=>params[:dept])
    end
  end

end
