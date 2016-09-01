class GeneralMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.general_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
      @user = User.find user.id
      @url  = edit_password_reset_url(@user.reset_password_token)
      mail(:to => user.email,
           :subject => "Your Community Cats colony management password has been reset") do |format|
        format.text
      end 
  end


  def invite_user_email(token,inviter)
    @inviter_email = inviter.email
    @email = token.email
    role = token.role
    code = token.token
    @url = new_user_url+"?invite=#{code}"

    mail(:to => @email,
         :subject => "Invite to join the Community Cats colony app") do |format|
      format.html
    end 

  end

end
