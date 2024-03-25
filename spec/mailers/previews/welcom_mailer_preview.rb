# Preview all emails at http://localhost:3000/rails/mailers/welcom_mailer
class WelcomeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcom_mailer/send_when_signup
  def send_when_signup
    WelcomeMailer.send_when_signup
  end

end
