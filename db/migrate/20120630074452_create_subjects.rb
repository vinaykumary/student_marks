class CreateSubjects < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
      t.string "subject_code" , :null =>false
      t.string "name", :null =>false
      t.integer "semester" , :null =>false
      t.integer "credits",  :null =>false
      t.integer "department_id"
    end
    add_index("subjects","subject_code")
  end

  def down
    remove_index("subjects","subject_code")
    drop_table :subjects
  end
end
