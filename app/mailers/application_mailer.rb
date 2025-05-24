class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@example.com"

  def reset_password_email(user)
    @user = user
    @token = user.reset_password_token
    mail(
      to:      @user.email,
      subject: "Сброс пароля на VectorsApp"
    )
  end
end
