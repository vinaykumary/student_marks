module StudentsHelper
def sortable(column, title = nil,department_id,semester)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :dept=>department_id,:semester=>semester}
  end
end
