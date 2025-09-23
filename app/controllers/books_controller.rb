class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner!, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book = Book.new
    @sidebar_user = current_user
  end

  def show
    @sidebar_user = current_user
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      @books = Book.includes(:user).order(created_at: :desc)
      @sidebar_user = current_user   # ✅ ต้องเพิ่ม
      flash.now[:alert] = "error: Could not create book."
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      flash.now[:alert] = "error: Could not update book."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_owner!
    return if @book.user == current_user
    redirect_to books_path, alert: "error: You can edit only your own book."
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end