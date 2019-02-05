class TopicsController < ApplicationController
  before_action :get_forum
  before_action :get_topic
  before_action :authorize_user!
  def show
  end

  private
    def get_forum
      @forum = Forum.first
    end

    def get_topic
      @topic = Topic.find_by_id(params[:id])
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
