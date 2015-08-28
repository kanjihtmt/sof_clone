require 'rails_helper'

describe TopsController do
  describe 'GET #index' do
    it 'トップページが表示されること' do
      get :index
      expect(response).to render_template('index')
    end

    it '質問が取得できること' do
      question1 = create(:question, id: 1)
      question2 = create(:question, id: 2)
      get :index
      expect(assigns(:questions)).to match_array([question2, question1])
    end
  end
end
