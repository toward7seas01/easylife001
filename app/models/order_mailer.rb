class OrderMailer < ActionMailer::Base

  def confirm(user)
    subject    '来自Easylife的激活邮件'
    recipients user.email
    body       :user => user
  end

end
