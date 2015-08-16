require 'rails_helper'

describe User do
  it 'はname, email, passwordが入力されていれば有効な状態であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'はnameの入力がなければ無効であること' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください。")
  end

  it 'はemailの入力がなければ無効であること' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください。")
  end

  it 'はpassowordの入力がなければ無効であること' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください。")
  end

  it 'はnameが4文字以上20文字以内であれば有効であること' do
    user = build(:user, name: 'ruby')
    expect(user).to be_valid

    user = build(:user, name: '12345678901234567890')
    expect(user).to be_valid
  end

  it 'はnameが4文字以上でなければ無効であること' do
    user = build(:user, name: 'red')
    user.valid?
    expect(user.errors[:name]).to include("は4文字以上で入力してください。")
  end

  it 'はnameが20文字以内でなければ無効であること' do
    user = build(:user, name: '123456789012345678901')
    user.valid?
    expect(user.errors[:name]).to include("は20文字以内で入力してください。")
  end

  it 'はemailが有効な入力あれば有効であること' do
    user = build(:user, email: 'kanji@example.com')
    expect(user).to be_valid
  end

  it 'はemailが有効な入力でなければ無効であること' do
    user = build(:user, email: 'kanji.example.com')
    user.valid?
    expect(user.errors[:email]).to include('は不正な値です。')
  end

  it 'はpassowordが8文字以上であれば有効であること' do
    user = build(:user, password: 'kanji123')
    expect(user).to be_valid
  end

  it 'はpassowordが8文字以上でなければ無効であること' do
    user = build(:user, password: 'kanji12')
    user.valid?
    expect(user.errors[:password]).to include('は8文字以上で入力してください。')
  end
end
