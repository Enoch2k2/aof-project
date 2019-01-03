ActiveAdmin.register User do
  controller do
    def permitted_params
      params.require(:user).permit(:email, :password, :password_confirmation, :superadmin)
    end
  end
  
  index do
    selectable_column
    id_column
    column :email
    column :superadmin
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end
  
  filter :email
  filter :superadmin
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :email
      f.input :superadmin, :label => "Super Administrator"
    end
    f.actions
  end
  
  create_or_edit = Proc.new {
    @user            = User.find_or_create_by(id: params[:id])
    @user.superadmin = params[:user][:superadmin]
    # binding.pry
    @user.attributes = permitted_params.delete_if do |k, v|
      (k == "superadmin") ||
      (["password", "password_confirmation"].include?(k) && v.empty? && !@user.new_record?)
    end
    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit
end
