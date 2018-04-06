class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@example.com'
  # 在 Application 邮件程序中设定默认的发件人地址
  layout 'mailer'
end
