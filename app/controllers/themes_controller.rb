class ThemesController < ApplicationController
  before_action :authenticate_user!

  def update
    requested_theme = params[:theme]
    allowed_themes = %w[classic modern]

    return head :unprocessable_entity unless allowed_themes.include?(requested_theme)

    current_user.update!(theme: requested_theme)

    head :no_content
  end
end
