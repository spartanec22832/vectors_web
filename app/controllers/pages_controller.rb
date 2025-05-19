class PagesController < ApplicationController
  def home
  end

  def history
  end

  def support
    render "pages/support"
  end
  def profile
    render "pages/profile"
  end
end