module ApplicationHelper
  def markdown(text)
    options = { autolink: true, fenced_code_blocks: true }
    render = Redcarpet::Render::HTML.new hard_wrap: true
    Redcarpet::Markdown.new(render, options).render text
  end
end
