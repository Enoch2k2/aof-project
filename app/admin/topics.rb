ActiveAdmin.register Topic do
  controller do
    def permitted_params
      if params[:topic]
        params.require(:topic).permit(:name, :content)
      end
    end

    def create
      @topic = Forum.first.topics.build(params[:topic].permit!)
      if @topic.save
        redirect_to admin_dashboard_path
      else
        flash[:error] = "Didn't work"
        redirect_to new_admin_topic_path(params[:id])
      end
    end

    def edit
      @topic = Topic.find_by_id(params[:id])
    end

    def update
      @topic = Topic.find_by_id(params[:id])
      if @topic.update(params[:topic].permit!)
        redirect_to admin_dashboard_path
      else
        flash[:error] = "Didn't work"
        redirect_to edit_admin_topic_path(params[:id])
      end
    end
  end
  
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    actions
  end
  
  filter :name
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
