class UsersController < ApplicationController
  before_action :authenticate_user!           # ไม่ล็อกอิน → ไปหน้า login
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_myself!, only: [:edit, :update]

  def index
    @sidebar_user = current_user
    @book = Book.new
    @users = User.order(:id)
  end

  def info
    @sidebar_user = current_user
    @book = Book.new
    @books = current_user.books
  end

  def show
    @sidebar_user = current_user
    @book = Book.new
    @books = @user.books.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile was successfully updated."
    else
      flash.now[:alert] = "error: Could not update profile."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # only current user
  def ensure_myself!
    return if @user == current_user
    redirect_to user_path(current_user), alert: "error: You can edit only your own profile."
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end