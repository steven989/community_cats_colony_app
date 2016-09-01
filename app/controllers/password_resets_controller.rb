class PasswordResetsController < ApplicationController
skip_before_filter :require_login
  def create
    @user = User.find_by_email(params[:email])

    # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
    @user.deliver_reset_password_instructions! if @user

    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    if @user
        redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
    else
        redirect_to(root_path, :alert => 'Email could not be found. Please register your colony')
    end
    
  end

  def edit
    seed = rand(0...100)

    search_result = Unsplash::Photo.search("cats", page=1, per_page = 100)[seed]
    while search_result.blank?
      search_result = Unsplash::Photo.search("cats", page=1, per_page = 100)[seed]
    end
    @background_photo = search_result.urls["small"]


    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      auto_login(@user)
      redirect_to look_up_colonies_path
    else
      render :action => "edit"
    end
  end
end
