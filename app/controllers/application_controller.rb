class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # 在 Application 控制器中引入 Sessions 辅助模块
  private
  # 确保用户已登录 
  def logged_in_user
   unless logged_in?
     store_location
     flash[:danger] = "Please log in." 
     redirect_to login_url
   end
  end
end
