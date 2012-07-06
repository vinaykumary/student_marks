class AddExamDate < ActiveRecord::Migration
  def up
    add_column("exams","date",:datetime)
  end

  def down
        remove_column("exams","date")
  end
end
