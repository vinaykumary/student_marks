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
      redirect_to :action=>'list',:dept=>@exam.department_id
      flash[:notice]="New Exam added"
    else
      render('new')
      flash[:notice]="Error in Adding Exam"
    end
  end

  # Reconstruct a date object from date_select helper form params
  def build_date_from_params(field_name, params)
    Date.new(params["#{field_name.to_s}(1i)"].to_i,
            params["#{field_name.to_s}(2i)"].to_i,
             params["#{field_name.to_s}(3i)"].to_i)
  end


end
