class UsersController < ApplicationController
 before_action:logged_in_user,only:[:index,:edit,:update, :destroy]  
 # 保护 edit 和 update 动作的 correct_user 前置过滤器
 before_action:correct_user, only:[:edit,:update]
 before_action:admin_user, only: :destroy
 # 添加 logged_in_user 前置过滤器
  def show
    @user = User.find(params[:id])
    @micropposts = @user.micropposts.paginate(page:params[:page])
    
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    # 创建用户，param获取user
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
 par
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Users 控制器的 update 动作
      flash[:success] = "Profile updated"
      redirect_to @user
      # 处理更新成功的情况 
    else
    render 'edit' 
    end
  end
  # :Users 控制器的 index 动作
  dex index
      @users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless FILL_IN
  end
    
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


private


   def user_params
     params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
   end


  # 前置过滤器
  # 确保用户已登录 
  def logged_in_user
    unless logged_in?
     store_logged_in?
     flash[:danger] = "Please log in." 
     
     redirect_to login_url
  end


 # 确保是正确的用户 
 def correct_user
  @user = User.find(params[:id])
  redirect_to(root_url) unless current_user?(@user)
 end

 # 确保是管理员
 def admin_user
  redirect_to(root_url) unless current_user.admin?
 end

end
