class PagesController < ApplicationController
  def home
  end

  def history
    if user_signed_in?
      @operation = current_user.operations.order("created_at DESC")
      render "pages/history"
    else
      flash.now[:alert] = "Вы не авторизованы, история недоступна"
      render "pages/home"
    end
  end

  def support
    render "pages/support"
  end
  def profile
    if user_signed_in?
      render "pages/profile"
    else
      flash.now[:alert] = "Вы не авторизованы, профиль недоступен"
      render "pages/home"
    end

  end
end