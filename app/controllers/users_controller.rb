class UsersController < ApplicationController

 def index
   @user = current_user
   @book = Book.new
   @users = User.all
 end



 def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
 end

 def edit
   # @users = User.new
   @user = User.find(params[:id])
   if @user != current_user
     redirect_to user_path(current_user.id)
   end
 end

 def update
    @user = User.find(params[:id])
    if@user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user.id)
    else
     render :edit
    end
 end

private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction )
  end

end