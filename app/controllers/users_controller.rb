class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:login]

  def login
        seed = rand(0...100)
        @background_photo = Unsplash::Photo.search("cats", page=1, per_page = 100)[seed].urls["small"]
  end

  # GET /users
  # GET /users.json
  def index
    @current_users = User.admins
    @pending_users = UserToken.admins

    @users = []

    @current_users.each {|cu| @users.push({id:cu.id,email:cu.email,created_at:cu.created_at,role:cu.role, status:"current"})}
    @pending_users.each {|pu| @users.push({id:pu.id,email:pu.email+" (invited - pending sign up)",created_at:pu.created_at,role:pu.role,status:"pending"})}

    puts '---------------------------------------------------'
    puts @users.inspect
    puts '---------------------------------------------------'

    respond_to do |format|
      format.html {
        render partial: 'index'
      }      
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def invite_user
    respond_to do |format|
      format.html {
        render partial: 'invite_user'
      }  
    end
  end

  def send_invite
    email = params[:email]
    if User.where(email:email).length > 0
      status = 'fail'
      message = 'This user already exists'
    elsif UserToken.where(email:email).length > 0
      status = 'fail'
      message = 'There''s already a pending invite for this user'
    else
      begin
        token_object = UserToken.create_token(email,"admin")
        GeneralMailer.invite_user_email(token_object,current_user).deliver
      rescue => error
        status = 'fail'
        message = error.message
      else
        status = 'success'
        message = 'Invitation email has been delivered'
      end
    end

    respond_to do |format|
      format.json {
        render json: {status:status,message:message}.to_json
      } 
    end
  end

  # GET /users/new
  def new
    seed = rand(0...100)
    @background_photo = Unsplash::Photo.search("cats", page=1, per_page = 100)[seed].urls["small"]
    invite = params[:invite]
    @token = UserToken.find_by_token(invite)

    @user = User.new

  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      if token = UserToken.find_by_token(params[:token])
        @user.update_attributes(role:token.role)
        UserToken.find_by_token(params[:token]).destroy
      end
      redirect_to look_up_colonies_path
    else
      redirect_to(new_user_path+"?invite=#{params[:token]}", alert: @user.errors.full_messages.join(", "))        
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to look_up_colonies_path

  end

def delete_token
    @token = UserToken.find(params[:id])
    @token.destroy
    redirect_to look_up_colonies_path
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
