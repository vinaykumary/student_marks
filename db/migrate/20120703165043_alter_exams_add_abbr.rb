class AlterExamsAddAbbr < ActiveRecord::Migration
  def up
    add_column("exams","abbreviation",:string)
  end

  def down
    remove_column("exams","abbreviation")
  end
end
