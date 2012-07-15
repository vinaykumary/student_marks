class AlterMarksResult < ActiveRecord::Migration
  def up
    change_column("marks","result",:string)
  end

  def down
    change_column("marks","result",:boolean)
  end
end
