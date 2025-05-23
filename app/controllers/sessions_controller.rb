class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    @user = user
    unless user
      flash.now[:alert] = "Пользователь не найден"
      return render "pages/home"
    end

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Успешный вход"
      AuditLog.create!(
        user:           @user,
        event_type:     :login
      )
    else
      flash.now[:alert] = "Неверный пароль"
      render "pages/home"
    end
  end

  def delete
    session.delete(:user_id)
    flash[:notice] = "Вы успешно вышли из аккаунта"
    AuditLog.create!(
      user:           @user,
      event_type:     :logout
    )
    redirect_to login_path
  end

end