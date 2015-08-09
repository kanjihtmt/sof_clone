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

  def answers_path?(controller)
    if controller == 'answers'
      true
    else
      false
    end
  end

  def status(question = nil)
    return 'unanswered' if !question.is_a? Question

    if question.answers_count > 0 && question.best_answer_id
      'answered-accepted'
    elsif question.answers_count > 0
      'answered'
    else
      'unanswered'
    end
  end
end
