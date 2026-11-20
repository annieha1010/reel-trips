module ApplicationHelper
  # Render markdown properly: https://github.com/vmg/redcarpet
  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true).render(text.to_s).html_safe
  end

  # def theme_class
  #   current_user&.theme.presence || "classic"
  # end

  # Returns the CSS class that represents the current user’s theme.
  # If no user is signed in, we fall back to the default “classic”.
  def theme_class
    if defined?(current_user) && current_user.present?
      current_user.theme
    else
      "classic"
    end
  end
end
