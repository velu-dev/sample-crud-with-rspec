require 'rails_helper'
require 'byebug'
require 'spec_helper'
RSpec.describe "UsersController", type: :request do
	describe "GET /users" do
	 it "Login Via username and password" do
        #post "/users", params: {:user => {fullname: "velusamy" , email: "velusamyvnp@gmail.com", password: "password", phone: "23456789"}}
                post sessions_login_auth_path, params: {username: "velusamy" , password: "password" }
                resp = expect(response.status).to eq 200
#                expect(flash[:notice]).to eq "Invalid Username or Password"
        end

    	it "Load all the users data from User table" do
      		get users_path
     		expect(response.code).to eq "302"
    	end
    	it "Create user with correct params" do
    		get "/users/new"
    		post "/users", params: {:user => {fullname: "velusamy" , email: "email@gmail.com", password: "password", mobile: "23456789"}}
    		resp = expect(response.status).to eq 302
    		expect(flash[:notice]).to eq "User was successfully created."
    	end

    	it "create an exception error" do
    		get "/users/new"
    		post "/users", params: {:user => {fullname: "velusamy" , email: "email@gmail.com" ,password: "password", mobile: "23456789"}}
    		# expect(flash[:status]).to eq "unprocessable_entity"
    	end


    	it "update user success method" do
    		user = User.create({fullname: "velusamy" , email: "email@gmail.com", password: "password", mobile: "23456789"})
    		puts user.fullname
    		put "/users/#{user.id}", params: {:user => {firstname: "vetrivel"}}
    		puts User.find(user.id).fullname
    		 expect(response.status).to eq 302
    	#expect(flash[:notice]).to eq "User was successfully updated."
    	end

    	it "user delete success method0" do
    		user = User.create(fullname: "velusamy" , email: "email@gmail.com", password: "password", mobile: "23456789")
    		delete "/users/#{user.id}"
    		expect(response.status).to eq 302
    		#expect(flash[:notice]).to eq "User was successfully destroyed."
    	end
    end

end
