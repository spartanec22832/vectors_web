class RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Регистрация прошла успешно"
      redirect_to root_path
    else
      flash.now[:alert] = "Ошибка регистрации! Проверьте форму"
      render "pages/home"
    end
  end

  def user_params
    params.permit(:email, :name, :password)
  end
end