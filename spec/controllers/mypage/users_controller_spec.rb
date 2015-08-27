require 'rails_helper'


describe Mypage::UsersController do
  describe 'GET #show' do
    @user = login_user

    it '正しくMyページの基本情報画面が表示されること' do
      get :show, @user
      expect(response).to render_template('mypage/users/show')
    end
  end

  describe 'GET #edit' do
    @user = login_user

    it '正しく基本情報編集画面が表示されること' do
      get :edit, @user
      expect(response).to render_template('mypage/users/edit')
    end
  end

  describe 'POST #update' do
    @user = login_user
    it '正しく更新されること' do
      put :update, id: @user, user: attributes_for(:user)
      expect(response).to redirect_to mypage_users_url(@user)
    end

    it '保存に失敗した場合は再度editテンプレートを表示すること' do
      put :update, id: @user, user: { name: nil }
      expect(response).to render_template('mypage/users/edit')
    end
  end
end
