class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.with_attached_image.find_newest_books(params[:page])
  end

  def new
    @book = Book.new
  end

  def show
    # 本とreviewはhas_manyの関係にあるのでincludesでreviewsユーザーを含めてSQLで一括で情報を取ってくる
    # @book = Book.with_attached_image.includes(:reviews, :user).find(params[:id])
    @book = Book.with_attached_image.find(params[:id])
  end

  def edit
    
  end

  def update
    
    if @book.update(book_params)
      redirect_to @book, notice: "書籍を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    
    @book.destroy
    redirect_to books_path, notice: "書籍を削除しました。"
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "書籍を登録しました。"
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :price, :publish_date, :description, :new_image, :category_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
