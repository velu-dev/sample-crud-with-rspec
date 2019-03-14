class SessionsController < ApplicationController
#efore_filter :authenticate_user, :only => [:home, :profile, :setting]
before_action :save_login_state, :only => [:login, :login_auth, :otp, :authenticate]
  def index
	byebug
  end
  def otp
	user = User.find(session[:user_id])
	if user.otp == params[:otp]
		session[:is_login] = true
		flash[:notice] = "OTP Has Been Verified Successfully."
	      	redirect_to users_path
	else
	session[:is_login] = false
	flash[:notice] = "Invalid Otp Please login again"
	render "authenticate"
	end
  end
  def login
  end

  def logout
  
  end
  def authenticate
	
  end

  def login_auth
	username = params[:username]
	password = params[:password]
	if username.split("").include?"@"
		user = User.find_by_email(username)
	else 
		user = User.find_by_fullname(username)
	end  
	if user && user.password == password
		otp = rand.to_s[2..7] 
		session[:user_id]= user.id
		user.update(otp: otp)
		UserMailer.send_mail(user.email, otp).deliver_now!
		flash[:notice] = "User loging in check your mail"
                flash[:color]= "success"
		redirect_to sessions_authenticate_path
	else 
		flash[:notice] = "Invalid Username or Password"
      		flash[:color]= "invalid"
      		render "login"	
	end
  end
end
