require 'rails_helper'

describe Answer do
  before do
    @question = create(:question)
    @user = create(:user)
  end

  it "は本文、質問、回答者の入力があれば有効であること" do
    answer = create(:answer, question: @question, answerer: @user)
    expect(answer).to be_valid
  end

  it "は本文が未入力であれば無効であること" do
    answer = build(:answer, question: @question, answerer: @user, body: nil)
    answer.valid?
    expect(answer.errors[:body]).to include("を入力してください。")
  end

  it "は本文が20文字以上でなければ無効であること" do
    answer = build(:answer, question: @question, answerer: @user, body: '１２３４５６７８９０１２３４５６７８９')
    answer.valid?
    expect(answer.errors[:body]).to include("は20文字以上で入力してください。")
  end

  it "は質問の登録がなければ無効であること" do
    answer = build(:answer, question: nil, answerer: @user)
    answer.valid?
    expect(answer.errors[:question_id]).to include("を入力してください。")
  end

  it "は回答者がなければ無効であること" do
    answer = build(:answer, question: @question, answerer: nil)
    answer.valid?
    expect(answer.errors[:answerer_id]).to include("を入力してください。")
  end
end
