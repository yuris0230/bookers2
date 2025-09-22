class ListController < ApplicationController

  private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
