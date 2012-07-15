module MarksHelper
def mark_sortable(column, title = nil,exam,subject)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :exam=>exam,:subject=>subject}
  end
end
