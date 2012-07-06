class SubjectsController < ApplicationController
  def index
    @departments=Department.all
  end

  def list
    @department=params[:dept]
    @semester=params[:semester]
    @subjects=Subject.where("department_id=#{@department} AND semester=#{@semester}")
  end

  def show
    @subject=Subject.find(params["id"])
  end

  def new
    @subject=Subject.new
  end

  def create
    #echo "******* #{params[:subject][department_id]}"
    @subject=Subject.new(params[:subject])
    #echo "###########{@subject.department_id}"
    if @subject.save
      redirect_to(:action => 'list',:semester=>@subject.semester,:dept=>@subject.department_id)
      flash[:notice]="New Subject created"
    else
      render('new')
    end
  end

  def edit
    @subject=Subject.find(params["id"])
  end

  def update
    @subject=Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      redirect_to(:action => 'show',:id=>params[:id])
      flash[:notice]="Subject Updated"
    else
      render('edit')
    end
  end

  def delete
    @subject=Subject.find(params["id"])
  end

  def destroy
    subject=Subject.find(params[:id])
    @department=subject.department_id
    @semester=subject.semester
    subject.destroy
    flash[:notice]="Subject Deleted"
    redirect_to(:action => 'list',:dept=>@department,:semester=>@semester)
  end


end
