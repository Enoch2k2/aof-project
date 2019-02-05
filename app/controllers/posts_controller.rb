class PostsController < ApplicationController
  before_action :get_forum
  before_action :get_topic
  before_action :get_post, only: [:show, :edit, :update]
  before_action :authorize_user!

  def new
    @url = topic_posts_path(@topic)
    @post = @topic.posts.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to topic_post_path(@topic, @post)
    else
      flash.now[:notice] = "You must fill out all fields"
      render :new
    end
  end

  def show
    @comment = @post.comments.build(user_id: current_user.id)
  end

  def edit
    @url = topic_post_path(@topic, @post)
  end

  def update
    if @post.update(post_params)
      redirect_to topic_post_path(@topic, @post)
    else
      flash.now[:notice] = "You must fill out all fields"
      render :edit
    end
  end

  private
    def get_forum
      @forum = Forum.first
    end

    def get_topic
      @topic = Topic.find_by_id(params[:topic_id])
    end

    def get_post
      @post = Post.find_by_id(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :topic_id, :user_id)
    end

    def authorize_user!
      if !user_signed_in?
        flash[:notice] = 'you must be logged in to view this page'
        redirect_to new_user_registration_path
      elsif !current_user.member
        flash[:notice] = 'you must be a member to view this page'
        redirect_to root_path  
      end
    end
end
