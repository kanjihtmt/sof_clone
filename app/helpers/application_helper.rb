module ApplicationHelper
  def markdown(text)
    options = { autolink: true, fenced_code_blocks: true }
    render = Redcarpet::Render::HTML.new hard_wrap: true
    Redcarpet::Markdown.new(render, options).render text
  end

  def current_header
    begin
      ACTIVE_HEADER_LINKS[controller_name.to_sym][action_name.to_sym]
    rescue NoMethodError
      nil
    end
  end
end
