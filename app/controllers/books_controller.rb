class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.where(:created_at=> 6.months.ago..Time.now).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @user = current_user
    @books_all = Book.all


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