module ApplicationHelper
  # Render markdown properly: https://github.com/vmg/redcarpet
  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true).render(text.to_s).html_safe
  end
end
