class AlterResultsAddResult < ActiveRecord::Migration
  def up
    add_column("results","result",:string)
  end

  def down
    remove_column("results","result")
  end
end
