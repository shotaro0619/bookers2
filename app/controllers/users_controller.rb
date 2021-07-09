class UsersController < ApplicationController
    
before_action :authenticate_user!, only: [:show]

 def index
   @user = current_user
   @book = Book.new
   @users = User.all
 end



 def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
          @currentUserEntry.each do |cu|
            @userEntry.each do |u|
              if cu.room_id == u.room_id then
                @isRoom = true
                @roomId = cu.room_id
              end
            end
          end
          unless @isRoom
            @room = Room.new
            @entry = Entry.new
          end
    end
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