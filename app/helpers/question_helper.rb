module QuestionHelper
  def order_by_tab(tab)
    case tab
      when 'active'
        {updated_at: :desc}
      when 'oldest'
        {created_at: :asc}
      else
        {body: :asc}
    end
  end

  def is_answers_path?(controller)
    return true if controller == 'answers'
    false
  end
end
