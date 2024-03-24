# Preview all emails at http://localhost:3000/rails/mailers/welcom_mailer
class WelcomMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcom_mailer/send_when_signup
  def send_when_signup
    WelcomMailer.send_when_signup
  end

end
