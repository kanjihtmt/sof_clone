FactoryGirl.define do
  factory :user do
    id 1
    email "kanji@example.com"
    password 'kanji1234'
    name "kanji"
    location "広島県"
    about_me "こんにちは、世界"
  end
end
