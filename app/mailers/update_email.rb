class UpdateEmail < ActionMailer::Base
  default from: "from@example.com"
  def followerNews(to_email)
    @greeting = "Hi"
    mail to: to_email, :subject => "New Guide has been published by #"
  end
end
