class BookCommentsController < ApplicationController
def create
    # @user = User.find(params[:user_id])
    @book = Book.find(params[:book_id])
    @user = @book.user
    # @book = @user.book_comments.new(book_comment_params)
    comment = current_user.book_comments.build(book_comment_params)
    comment.book_id = @book.id
    comment.save
end

def destroy
    @book = Book.find(params[:book_id])
    @user = @book.user
    book_comment = @book.book_comments.find(params[:id])
		book_comment.destroy
end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
