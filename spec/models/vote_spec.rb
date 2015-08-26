require 'rails_helper'

describe Vote do
  it "はvalue, votable_id, votable_id, user_idが入力されていれば有効な状態であること" do
    vote = build(:vote)
    expect(vote).to be_valid
  end

  it "は投票値がなければ無効であること" do
    vote = build(:vote, value: nil)
    vote.valid?
    expect(vote.errors[:value]).to include("を入力してください。")
  end

  it "はvotable_idの入力がなければ無効であること" do
    vote = build(:vote, votable_id: nil)
    vote.valid?
    expect(vote.errors[:votable_id]).to include("を入力してください。")
  end

  it "はvotable_typeの入力がなければ無効であること" do
    vote = build(:vote, votable_type: nil)
    vote.valid?
    expect(vote.errors[:votable_type]).to include("を入力してください。")
  end

  it "は投票者がいなければ無効であること" do
    vote = build(:vote, user_id: nil)
    vote.valid?
    expect(vote.errors[:user_id]).to include("を入力してください。")
  end

  it "同じユーザが2回投票することができないこと" do
    user = create(:user)
    Vote.create(value: 1, votable_type: 'Question', votable_id: 1, user: user)
    vote = Vote.new(value: -1, votable_type: 'Question', votable_id: 1, user: user)
    vote.valid?
    expect(vote.errors[:user_id]).to include("は2回以上行うことはできません")
  end
end
