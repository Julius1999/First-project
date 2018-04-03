class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) 
    if user && user.authenticate(params[:session][:password])
    # 登入用户，然后重定向到用户的资料页面 
    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_back_or user
    # 登入用户
    else
       flash.now[:danger] = 'Invalid email/password combination' # 不完全正确
      # 创建一个错误消息
       render 'new'
    end

  def destroy
    log_out if logged_in?
    redirect_to root_url
    # 销毁会话(退出用户)
  end
end
