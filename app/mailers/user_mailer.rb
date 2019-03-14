class UserMailer < ApplicationMailer
	def send_mail(mail, otp)
		@mail = mail
		@otp = otp
		mail(to: mail, subject: 'Welcome to Sams Gym')
	end
end
