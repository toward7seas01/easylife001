class ImagesController < BlogLikeController
  skip_filter :current_space
  before_filter :authentic

  add_methods(:ready_batch_delete, :ready_batch_update) do
    @images = Image.paginate(:all, :conditions => "(id%2) = 1", :page => params[:page], :per_page => 16)
  end

  def batch_update
    Image.update(params[:images].keys, params[:images].values)
    flash[:notice] = "已成功更新"
    redirect_to ready_batch_update_path(:page => params[:page])
  end

  def batch_delete
    Image.destroy(params[:ids].split(","))
    render :update do |page|
      page.replace ".destroy"
    end
  end

  def set_cover
    Cover.find(params[:cover_id]).update_attributes(:thumbnail_id => params[:id])
    redirect_to user_cover_path(:id => params[:cover_id])
  end

end
