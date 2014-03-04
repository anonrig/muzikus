class AdminMailer < ActionMailer::Base
  default from: "ynizipli@sabanciuniv.edu"

  def contact_email(name, email, subject, message)
  	@name = name
  	@email = email
  	@subject = subject
  	@message = message
  	mail(to: "yagiznizipli@me.com", subject: "Alfonso: #{@subject}")
  end
end
