require 'rails_helper'

describe QuestionHelper do
  describe '#sorted_answers_by_tab' do
    before do
      @question = create(:question)
      user =  create(:user,  email: 'aaa@example.com', id: 1)
      user2 = create(:user, email: 'bbb@example.com', id: 2)
      user3 = create(:user, email: 'ccc@example.com', id: 3)

      # 投票数2件の回答
      answer1 = create(:answer, id: 1, answerer: user, question: @question,
             created_at: 2.day.ago, updated_at: 2.day.ago)
      create(:vote, value: 1, votable_type: answer1.class.name, votable_id: answer1.id, user_id: 1)
      create(:vote, value: 1, votable_type: answer1.class.name, votable_id: answer1.id, user_id: 2)

      # 投票数0件の回答
      answer2 = create(:answer, id: 2, answerer: user, question: @question,
             created_at: 3.day.ago, updated_at: 1.day.ago)

      # 投票数3件の回答
      answer3 = create(:answer, id: 3, answerer: user, question: @question,
             created_at: 4.day.ago, updated_at: 3.day.ago)
      create(:vote, value: 1, votable_type: answer3.class.name, votable_id: answer3.id, user_id: 1)
      create(:vote, value: 1, votable_type: answer3.class.name, votable_id: answer3.id, user_id: 2)
      create(:vote, value: 1, votable_type: answer3.class.name, votable_id: answer3.id, user_id: 3)
    end

    it 'タブがアクティブの場合は更新日の降順でソートされた回答一覧を取得すること' do
      expect(helper.sorted_answers_by_tab(@question.answers, 'active').map(&:id))
        .to eq [2, 1, 3]
    end

    it 'タグが古い順の場合は作成日の昇順でソートされた回答一覧を取得すること' do
      expect(helper.sorted_answers_by_tab(@question.answers, 'oldest').map(&:id))
        .to eq [3, 2, 1]
    end

    it 'タブが票の場合は票が多い順でソートされた回答一覧を取得すること' do
      expect(helper.sorted_answers_by_tab(@question.answers, 'vote').map(&:id))
        .to eq [3, 1, 2]
    end
  end

  describe '#answers_path?' do
    it '現在実行中の処理がAnswersControllerであればtrueを返すこと' do
      allow(controller).to receive(:controller_name).and_return('answers')
      expect(helper.answers_path?).to be_truthy
    end

    it '現在実行中の処理がAnswersControllerでなければfalseを返すこと' do
      allow(controller).to receive(:controller_name).and_return('questions')
      expect(helper.answers_path?).to be_falsey
    end
  end

  describe '#status' do
    it '承認済みの回答がある質問の場合はanswered-accptedを返すこと' do
      question = create(:question, answers_count: 2, best_answer_id: 3)
      expect(helper.status(question)).to eq 'answered-accepted'
    end

    it '承認なしで回答がある質問の場合はansweredを返すこと' do
      question = create(:question, answers_count: 1, best_answer_id: nil)
      expect(helper.status(question)).to eq 'answered'
    end

    it '回答のない質問はunansweredを返すこと' do
      question = create(:question, answers_count: 0, best_answer_id: nil)
      expect(helper.status(question)).to eq 'unanswered'
    end

    it '[異常系] 質問でないオブジェクトを渡した場合unansweredを返すこと' do
      user = User.new
      expect(helper.status(user)).to eq 'unanswered'
    end
  end
end
