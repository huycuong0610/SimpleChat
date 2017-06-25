class UserNotifier < ActionMailer::Base
  default :from => 'huycuong0610@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_message_email(user)
    logger.debug "New article: #{@user}"
    @user = user
    mail( :to => 'huycuong0610@gmail.com',
    :subject => 'Thanks for signing up for our amazing app' )
  end
end