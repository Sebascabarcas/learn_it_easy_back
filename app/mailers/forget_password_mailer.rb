class ForgetPasswordMailer < ApplicationMailer

  def send_email(user_id, url, token)
    @user = User.find user_id
    @url = "#{url}/#{token}"
    deliver_mail( to: @user.email,
    subject: "Olvidaste tu contraseña?")
  end
end
