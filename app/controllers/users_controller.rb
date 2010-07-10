class UsersController < ApplicationController
  def new
	@user = User.new
	@title = "Sign Up!"
  end

  def show
	@title = user.name
	@user = User.find(params[:id])
  end

  def create
	@user = User.new
	if @user.save
		flash[:success] => "Thank you for signing up!"
		redirect_to @user
	else
		@title = "Sign Up"
		render 'new'
	end
  end
end
