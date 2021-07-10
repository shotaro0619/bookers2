class BooksController < ApplicationController

  def index
    @book = Book.new
    # if params[:option] == "A" || params[:option] == nil
    @books = Book.where(:created_at=> 6.weeks.ago..Time.now).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    # elsif params[:option] == "B"
    # @books = Book.all.order(created_at: :desc)
  # end
    @user = current_user
    # @books_all = Book.all
    @books_search= Book.all.order(params[:sort])
  end
  
  def sort
    @books = Book.all.order(created_at: :desc)
  end
  
  def like
    @books = Book.where(:created_at=> 6.weeks.ago..Time.now).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else
     @books = Book.all
     render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    impressionist(@book, nil, unique: [:ip_address])
    @user = @book.user
    @book_comment = BookComment.new
    # @user_me = current_user
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
    @book = Book.find(params[:id])
    if @book.user != current_user
     redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    @books = Book.find(params[:id])
    flash[:notice] = "Book was successfully destroyed."
    @books.destroy
    redirect_to books_path
  end



  private

  def book_params
    params.require(:book).permit(:title, :body, :category)
  end


end