class PopulateDepartments < ActiveRecord::Migration
  def up
    Department.create :dept_code=>104,:name=>CSE
    Department.create :dept_code=>105,:name=>EEE
    Department.create :dept_code=>106,:name=>ECE
    Department.create :dept_code=>205,:name=>IT
  end

  def down
  end
end
