class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_save 后有一个块，块中的代码调用字符串的 downcase 方法，把用户的电子邮件 地址转换成小写形式。
  #   before_save { email.downcase! }
  # #before_save 回调的另一种实现方式
    vaildates:name, presence: true,length:{maximum: 50}
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # #允许电子邮件地址中有多个点号的正则表达式
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #不允许电子邮件地址中有多个点号的正则表达式

    validates :email, presence: true, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  #测试电子邮件地址唯一性验证,不区分大小写, case_sensitive: false，Rails 会自动指定 :uniqueness 的值为 true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
  #实现安全密码的全部代码

end
