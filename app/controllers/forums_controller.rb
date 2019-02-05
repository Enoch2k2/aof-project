class ForumsController < ApplicationController
  before_action :authorize_user!

  def index
    @forum = Forum.first
  end

  private
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
