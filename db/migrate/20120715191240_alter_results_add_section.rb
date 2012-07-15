class AlterResultsAddSection < ActiveRecord::Migration
  def up
    add_column("results","section",:string)
  end

  def down
    remove_column("results","section")
  end
end
