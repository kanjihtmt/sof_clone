require 'rails_helper'

describe ApplicationHelper do
  describe "#markdown" do
    it 'Markdownをhtmlにレンダリングされていること' do
      before =<<EOF
# Markdownのテスト
Markdownのテストを行います。
## 期待する条件
 * HTMLになっていること
 * エラーが出力されないこと

```
module ApplicationHelper
  def merkdown(text)
    puts 'Hello Markdown'
  end
end
```
EOF
      after =<<EOF
<h1>Markdownのテスト</h1>

<p>Markdownのテストを行います。</p>

<h2>期待する条件</h2>

<ul>
<li>HTMLになっていること</li>
<li>エラーが出力されないこと</li>
</ul>

<pre><code>module ApplicationHelper
  def merkdown(text)
    puts &#39;Hello Markdown&#39;
  end
end
</code></pre>
EOF
      expect(helper.markdown(before)).to eq after
    end
  end

  describe '#current_header' do
    it "コントローラ・アクションを指定すれば現在アクティブにすべきヘッダを返すこと" do
      controller.stub(:controller_name).and_return('users')
      controller.stub(:action_name).and_return('index')
      expect(helper.current_header).to eq 'users'
    end

    it "該当しないコントローラ・アクションの場合はnilを返すこと" do
      controller.stub(:controller_name).and_return('users')
      controller.stub(:action_name).and_return('hoge')
      expect(helper.current_header).to be_nil
    end
  end
end
