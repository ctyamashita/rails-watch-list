class ListsController < ApplicationController
  before_action :set_list, only: %i[show destroy]

  def index
    @list = List.new
    @lists = List.all
  end

  def show
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(strong_params)
    if @list.save
      redirect_to lists_path
    else
      @lists = List.all
      render :index
      # render :new
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def strong_params
    params.require(:list).permit(:name, :photo)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
