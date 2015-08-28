require 'rails_helper'

describe QuestionHelper do
  describe '#order_by_tab' do
    it 'タブがアクティブの場合は更新日の降順の条件を取得すること'
    it 'タグが古い順の場合は作成日の昇順の条件を取得すること'
    it 'タブが
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
