class CreateStudents < ActiveRecord::Migration
  def up
    create_table :students do |t|
      t.string "roll_no", :null=>false, :unique=>true
      t.string "name",:null=>false
      t.integer "department_id"
      t.integer "semester"
      t.string "section"
    end
    add_index("students","roll_no")
  end

  def down
    remove_index("students","roll_no")
    drop_table :students
  end
end
