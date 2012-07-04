class CreateExams < ActiveRecord::Migration
  def up
    create_table :exams do |t|
      t.string "name", :null => false
      t.integer "department_id"
      t.integer "semester"
    end
  end

  def down
    drop_table :exams
  end
end
