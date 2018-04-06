class User < ApplicationRecord
  # 确保用户的微博在删除用户的同时也被删除
  has_many :microposts, dependent: :destroy
  # 在 User 模型中添加 添加重设密码所需的方法,remember 方法
  attr_accessor :remember_token,:activation_token
  before_save :downcase_email
  before_create:create_activation_digest
  # before_save 后有一个块，块中的代码调用字符串的 downcase 方法，把用户的电子邮件 地址转换成小写形式。
  #   before_save { email.downcase! }
  # #before_save 回调的另一种实现方式
  validates :name, presence:true,length:{maximum:50}
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # #允许电子邮件地址中有多个点号的正则表达式
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #不允许电子邮件地址中有多个点号的正则表达式

    validates :email, presence: true, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  #测试电子邮件地址唯一性验证,不区分大小写, case_sensitive: false，Rails 会自动指定 :uniqueness 的值为 true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 },allnow_nill:true
    class << self
  ## 返回指定字符串的哈希摘要 
  def self.digest(string)
     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
     BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost) 
  end
  # 返回一个随机令牌 
  def self.new_token
     SecureRandom.urlsafe_base64 
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end
  
  # 如果指定的令牌和摘要匹配，返回 true 
  def authenticated?(remember_token)
    digest = send("#{attribute}_digest")
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token) 
  end
  # 忘记用户 
  def forget
     update_attribute(:remember_digest, nil)
  end
  
  # 激活账户 
  def activate
    update_columns(activated: FILL_IN, activated_at: FILL_IN)
  end
  # 发送激活邮件
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # 设置密码重设相关的属性 
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns((:reset_digest: FILL_IN, reset_sent_at: FILL_IN)
  end
  
  # 发送密码重设邮件
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now 
  end

  # 如果密码重设请求超时了，返回 true 
  def password_reset_expired?
     reset_sent_at < 2.hours.ago 
  end
  
  private
    # 把电子邮件地址转换成小写 
    def downcase_email
      self.email = email.downcase
    end



    #创建并赋值激活令牌和摘要
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = user.digest(activation_token)
    end

    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest,User..digest(remember_token))
    end 
  end
