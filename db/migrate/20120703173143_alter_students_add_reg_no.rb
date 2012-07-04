class AlterStudentsAddRegNo < ActiveRecord::Migration
  def up
    add_column("students","reg_no",:string)
  end

  def down
    remove_column("students","reg_no")
  end
end
