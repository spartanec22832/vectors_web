class PasswordsController < ApplicationController
  # пока на скорую руку накидал методов, надо обговаривать архитектуру
  def reset

  end

  def update
    # Проверяем старый пароль
    unless current_user.authenticate(params[:current_password])
      flash.now[:alert] = "Старый пароль неверен"
      return render "pages/profile"
    end

    if current_user.update(password: params[:new_password],
                           password_confirmation: params[:new_password_confirmation])
      redirect_to profile_page_path, notice: "Пароль успешно изменён"
    else
      flash.now[:alert] = "Пароли не совпадают"
      render "pages/profile"
    end
  end

end
