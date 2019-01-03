ActiveAdmin.register NewsPost do
  controller do
    def permitted_params
      if params[:news_post]
        params.require(:news_post).permit(:date, :title, :content, :image_url)
      end
    end

    def create
      @news_post = NewsPost.new(params[:news_post].permit!)
      if @news_post.save
        redirect_to admin_dashboard_path
      else
        flash[:error] = "Didn't work"
        redirect_to new_admin_news_post(params[:id])
      end
    end

    def edit
      @news_post = NewsPost.find_by_id(params[:id])
    end

    def update
      @news_post = NewsPost.find_by_id(params[:id])
      if @news_post.update(params[:news_post].permit!)
        redirect_to admin_dashboard_path
      else
        flash[:error] = "Didn't work"
        redirect_to edit_admin_news_post_path(params[:id])
      end
    end
  end
  
  index do
    selectable_column
    id_column
    column :date
    column :title
    column :created_at
    actions
  end
  
  filter :date
  filter :title
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :date
      f.input :title
      f.input :content
      f.input :image_url
    end
    f.actions
  end
end
