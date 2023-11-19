class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy
  before_action :set_list, only: [ :create]

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    # @bookmark.list = @list
      if @bookmark.save
        redirect_to bookmarks_path, notice: 'comment created successfully!'
      else
        raise
        render :new
      end
  end

    def destroy
      @bookmark.destroy
      redirect_to bookmarks_url, notice: 'Comment deleted successfully!'
    end

  private
    # Use callbacks to share common methods between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a bookmark of trusted parameters through.
    def bookmark_params
      params.require(:bookmark).permit(:comment, :movie)
    end
end
