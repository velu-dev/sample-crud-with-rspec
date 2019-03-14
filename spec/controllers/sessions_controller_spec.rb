require 'rails_helper'
require 'byebug'
require 'spec_helper'
RSpec.describe "SessionsController", type: :request do
        describe "GET /login" do
        it "Load all the users data from User table" do
                get sessions_login_path
                resp = expect(response).to be_successful #response.success
        end
	it "Create user with correct params" do
                get new_user_path
                post "/users", params: {:user => {fullname: "velusamy" , email: "velusamyvnp@gmail.com", password: "password", mobile: "23456789"}}
                resp = expect(response.status).to eq 302
                expect(flash[:notice]).to eq "User was successfully created."
        end
	it "Login Via username and password" do
	#post "/users", params: {:user => {fullname: "velusamy" , email: "velusamyvnp@gmail.com", password: "password", phone: "23456789"}}
		post sessions_login_auth_path, params: {username: "velusamy" , password: "password" }
                resp = expect(response.status).to eq 200
                expect(flash[:notice]).to eq "Invalid Username or Password"	
	end
	it "verify Otp" do
		@user = User.create({fullname: "velusamy" , email: "velusamyvnp@gmail.com", password: "password", mobile: "23456789"})
		 post sessions_login_auth_path, params: {username: "velusamy" , password: "password" }
	
		otp = User.find(1).otp		
		post sessions_otp_path , params: {otp: otp}
		expect(response.status).to eq 302
		expect(flash[:notice]).to eq "OTP Has Been Verified Successfully."

	end
    end

end

