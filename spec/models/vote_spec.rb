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

  describe '連続投票' do
    before do
      @user = create(:user)
    end

    context '同じユーザが2回連続投票' do
      it "up投票を連続投票できないこと" do
        create(:vote, value: 1, votable_type: 'Question', votable_id: 1, user: @user)
        vote = build(:vote, value: 1, votable_type: 'Question', votable_id: 1, user: @user)
        vote.valid?
        expect(vote.errors[:user_id]).to include("は2回以上行うことはできません")
      end

      it "down投票を連続投票できないこと" do
        create(:vote, value: -1, votable_type: 'Question', votable_id: 1, user: @user)
        vote = build(:vote, value: -1, votable_type: 'Question', votable_id: 1, user: @user)
        vote.valid?
        expect(vote.errors[:user_id]).to include("は2回以上行うことはできません")
      end
    end

    context '既に投票したものと逆の投票を行う' do
      it 'up投票の次にdown投票を行い、投票を取り消すことができること' do
        create(:vote, value: 1, votable_type: 'Question', votable_id: 1, user: @user)
        vote = build(:vote, value: -1, votable_type: 'Question', votable_id: 1, user: @user)
        vote.valid?
        expect(vote).to be_valid
      end

      it 'up投票の次にdown投票を行った後、投票はゼロにクリアされていること' do
        create(:vote, value: 1, votable_type: 'Question', votable_id: 1, user: @user)
        vote = build(:vote, value: -1, votable_type: 'Question', votable_id: 1, user: @user)
        vote.save!
        count = Vote.where(votable_type: 'Question', votable_id: 1, user: @user).count
        expect(count).to be 0
      end

      it 'down投票の次にup投票を行い、投票を取り消すことができること' do
        create(:vote, value: -1, votable_type: 'Question', votable_id: 1, user: @user)
        vote = build(:vote, value: 1, votable_type: 'Question', votable_id: 1, user: @user)
        vote.valid?
        expect(vote).to be_valid
      end

      it 'down投票の次にup投票を行った後、投票はゼロにクリアされていること' do
        create(:vote, value: -1, votable_type: 'Question', votable_id: 1, user: @user)
        vote = build(:vote, value: 1, votable_type: 'Question', votable_id: 1, user: @user)
        vote.save!
        count = Vote.where(votable_type: 'Question', votable_id: 1, user: @user).count
        expect(count).to be 0
      end
    end
  end
end
