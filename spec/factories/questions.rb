FactoryGirl.define do
  factory :question do
    title "質問テストタイトル"
    body "質問です。質問です。質問です。質問です。質問です。\n質問です。質問です。質問です。質問です。質問です。\n質問です。質問です。質問です。質問です。質問です。\n"
    questioner_id 1
    tag_list 'rails,ruby'
    before(:build) do |question|
      question.tags << FactoryGirl.build(:tag)
    end
  end
end
