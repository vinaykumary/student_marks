class AlterResultsAddNoFails < ActiveRecord::Migration
  def up
    add_column("results","no_failed",:integer)
  end

  def down
    remove_column("results","no_failed")
  end
end
