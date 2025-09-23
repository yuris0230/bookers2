class HomesController < ApplicationController
  def top
    if user_signed_in?
      @sidebar_user = current_user
      @book         = Book.new
      @books        = current_user.books.includes(:user).order(created_at: :desc)
    end
  end

  def about; end
end