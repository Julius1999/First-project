class PasswordResetsController < ApplicationController
  before_action:get_user, only:[:edit,:update] 
  
  before_action :valid_user, only: [:edit, :update]

  before_action :check_expiration,only:[
    :edit,:update]  # 第一种情况

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase) if @user
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = "Email sent with password reset instructions"
    redirect_to root_url
   else
    flash.now[:danger] = "Email address not found"
    render 'new' 
   end
  end

  def update
    if params[:user][:password].empty?
      # 第三种情况
      @User.error.add(:password,"Can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      # 第四种情况
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'  # 第二种情况
    end
  end

  def user_params
    params.require(:user).permit(:password,                       :password_confirmation)

  def edit
  end

private
   
  def user_params

    
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 确保是有效用户 
    def valid_user
      unless (@user && @user.activated? &&            @user.authenticated?(:reset,                               params[:id]))
       redirect_to root_url
      end
    end

    # 检查重设令牌是否过期 
    def check_expiration
      if @user.password_reset_expired?
           flash[:danger] = "Password reset has expired." redirect_to new_password_reset_url
      end 
    end
end