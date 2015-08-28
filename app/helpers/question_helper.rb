module QuestionHelper
  def sorted_answers_by_tab(answers, tab)
    case tab
      when 'active'
        answers.reorder({updated_at: :desc})
      when 'oldest'
        answers.reorder({created_at: :asc})
      when 'vote'
        answers.reorder({updated_at: :desc}).sort do |a, b|
          b.total_votes_count <=> a.total_votes_count
        end
      else
        answers.reorder({updated_at: :desc})
    end
  end

  def answers_path?
    if controller_name == 'answers'
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
