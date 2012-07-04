class CreateDepartments < ActiveRecord::Migration
  def up
    create_table :departments do |t|
      t.integer "dept_code" , :null => false
      t.string "name", :null => false
     end
  end

  def down
    drop_table :departments
  end
end
