class SearchesController < ApplicationController
  def search
    @method = params[:search_method]
    @word = params[:search_word]
    @model = params[:search_model]

    if @model == "1"
      @user = User.search(@method,@word)
    else
      @book = Book.search(@method,@word)
    end
  end
end
