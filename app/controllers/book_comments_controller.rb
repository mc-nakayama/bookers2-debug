class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    comment.save
    render :create
  end

  def destroy
  # refroute は画面からidを取得している
   refroute = Rails.application.routes.recognize_path(request.referrer)
   @book = Book.find(refroute[:id])
  # 
   comment = BookComment.find(params[:id])
   comment.destroy
   render :destroy
  end

    private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
