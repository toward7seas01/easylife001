class CoversController < BlogLikeController
  layout 'images'
  skip_filter :current_space

  def show
    @cover = Cover.find params[:id]
    unless show?(@cover)
      false_page and return
    end
    @images = @cover.images.paginate(:all, :page => params[:page], :per_page => 16)
  end


end
