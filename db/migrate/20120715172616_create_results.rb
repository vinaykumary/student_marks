class CreateResults < ActiveRecord::Migration
  def up
    create_table :results do |t|
        t.integer "student_id"
        t.integer "exam_id"
        t.integer "total"
        t.float "percentage"
        t.integer "rank"
    end
  end

  def down
    drop_table :results
  end
end
