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
