class ListsController < ApplicationController
  before_action :set_list, only: [ :show, :destroy]

  def index
    @lists = List.all
    # raise
  end

  def show
    @bookmark = Bookmark.where(list_id: params[:id])
    @review = Review.new(list_id: @list)
    # @bookmark = Movie.find(params[:id])
    # raise

  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)
      if @list.save
        redirect_to lists_path(@list), notice: 'List name created successfully!'
      else
        render :new
      end
  end

  def update
    if @list.update(list_params)
        redirect_to @list, notice: 'List name updated successfully!'
      else
        render :edit
      end
  end

    def destroy
      @list.destroy
      redirect_to lists_url, notice: 'Delete successfully!'
    end

  private
    # Use callbacks to share common methods between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:name)
    end
  end
