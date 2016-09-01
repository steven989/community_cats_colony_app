# Preview all emails at http://localhost:3000/rails/mailers/general_mailer
class GeneralMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/general_mailer/reset_password_email
  def reset_password_email
    GeneralMailer.reset_password_email
  end

end
