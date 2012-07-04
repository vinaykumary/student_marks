class RemAbbrAddAbbrExamsSubjects < ActiveRecord::Migration
  def up
    add_column("subjects","abbreviation",:string,:null=>false)
    remove_column("exams","abbreviation")
  end

  def down
    add_column("exams","abbreviation")
    remove_column("subjects","abbreviation")
  end
end
