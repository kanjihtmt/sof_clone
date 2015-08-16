require 'rails_helper'

describe CommentsController do

  describe 'GET #new' do
    let(:user) { build(:user) }

    before do
      @question = Question.create(
        id: 1,
        title: 'ActiveRecordの質問です',
        body: 'あああああああああああああああああああああああああああああああああああああ',
        questioner: user
      )
    end

    context '未ログイン' do
      it "未ログインの場合はアクセスできないこと" do
        question = Question.create(
          id: 1,
          title: 'ActiveRecordの質問です',
          body: 'あああああああああああああああああああああああああああああああああああああ',
          questioner: user
        )
        get :new, { :question_id => question.id }
        expect(response).to redirect_to user_session_url
      end
    end

    context 'ログイン済み' do
      login_user
      it "ログインしていればpartialをrenderすること" do
        #q = Question.new(
        #  id: 1,
        #  title: 'ActiveRecordの質問です',
        #  body: 'あああああああああああああああああああああああああああああああああああああ',
        #  tag_list: 'ruby,rails',
        #  questioner: user
        #)
        #q.save!
        #get :new, { :question_id => q.id }
        #expect(response).to render_template(:partial => 'comments/form')
      end
    end
  end
end
