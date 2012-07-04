# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120704004444) do

  create_table "departments", :force => true do |t|
    t.integer "dept_code", :null => false
    t.string  "name",      :null => false
  end

  create_table "exams", :force => true do |t|
    t.string  "name",          :null => false
    t.integer "department_id"
    t.integer "semester"
  end

  create_table "marks", :force => true do |t|
    t.integer "student_id"
    t.integer "exam_id"
    t.integer "subject_id"
    t.integer "marks"
    t.boolean "result"
  end

  create_table "students", :force => true do |t|
    t.string  "roll_no",       :null => false
    t.string  "name",          :null => false
    t.integer "department_id"
    t.integer "semester"
    t.string  "section"
    t.string  "reg_no"
  end

  add_index "students", ["roll_no"], :name => "index_students_on_roll_no"

  create_table "subjects", :force => true do |t|
    t.string  "subject_code",  :null => false
    t.string  "name",          :null => false
    t.integer "semester",      :null => false
    t.integer "credits",       :null => false
    t.integer "department_id"
    t.string  "abbr",          :null => false
    t.string  "abbreviation",  :null => false
  end

  add_index "subjects", ["subject_code"], :name => "index_subjects_on_subject_code"

end
