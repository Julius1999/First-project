class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    # 创建用户，param获取user
    if @user.save
      log_in @user
      # 注册后登入用户
      flash[:success] = "Welcome to the Sample App!"
      #用户注册成功后显示一个闪现消息
      redirect_to @user
      # 处理注册成功的情况
    else
      render 'new'
    end
  end
  private
   def user_params
     params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
   end
end
