class CommentsController < ApplicationController
  before_action :set_forum
  before_action :set_topic
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user!

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to topic_post_path(@topic, @post)
    else
      flash[:notice] = 'Must fill out required fields'
      redirect_to topic_post_path(@topic, @post)
    end
  end

  def edit
    redirect_to topic_post_path(@topic, @post) unless @comment.user == current_user
  end

  def update
    redirect_to topic_post_path(@topic, @post) unless @comment.user == current_user
    if @comment.update(comment_params)
      redirect_to topic_post_path(@topic, @post)
    else
      flash[:notice] = 'Must fill out required fields'
      redirect_to topic_post_path(@topic, @post)
    end
  end

  def destroy
    redirect_to topic_post_path(@topic, @post) unless @comment.user == current_user
    @comment.destroy
    redirect_to topic_post_path(@topic, @post)
  end

  private
    def set_forum
      @forum = Forum.first
    end

    def set_topic
      @topic = Topic.find_by_id(params[:topic_id])
    end

    def set_post
      @post = Post.find_by_id(params[:post_id])
    end

    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
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
