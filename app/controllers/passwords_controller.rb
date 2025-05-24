class PasswordsController < ApplicationController

  def reset
    if request.get?
      return render "passwords/reset"
    end
    if request.post?
      @user = User.find_by(email: params[:email])
      if @user
        @user.generate_password_reset!
        ApplicationMailer.reset_password_email(@user).deliver_now
        flash[:notice] = "Письмо отправлено на вашу почту"
        redirect_to root_path
      else
        flash.now[:alert] = "Пользователь с таким email не найден"
        render "passwords/reset"
      end
    end
  end

  def update
    # По ссылке из письма:
    if params[:token].present?
      user = User.find_by(reset_password_token: params[:token])
      unless user
        flash[:alert] = "Ссылка недействительна"
        return redirect_to password_reset_new_path
      end

      unless user.password_reset_period_valid?
        flash[:alert] = "Ссылка устарела, запросите сброс ещё раз"
        return redirect_to password_reset_new_path
      end

      if request.get?
        @token = params[:token]
        return render "passwords/confirmation"
      end

      if user.update(password: params[:password],
                     password_confirmation: params[:password_confirmation])
        user.clear_reset_password_token!
        redirect_to root_path, notice: "Пароль успешно сброшен"
      else
        flash.now[:alert] = "Ошибка сброса пароля"
        @token = params[:token]
        return render "passwords/confirmation"
      end
    else
    # Для дефолтной смены через профиль:
      unless current_user.authenticate(params[:current_password])
        flash.now[:alert] = "Старый пароль неверен"
        return render "pages/profile"
      end

      if current_user.update(password:               params[:new_password],
                             password_confirmation:  params[:new_password_confirmation])
        redirect_to profile_page_path, notice: "Пароль успешно изменён"
      else
        flash.now[:alert] = current_user.errors.full_messages.to_sentence
        render "pages/profile"
      end
    end
  end
end
