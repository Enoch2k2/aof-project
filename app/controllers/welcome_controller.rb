class WelcomeController < ApplicationController
  def index
    @news = NewsPost.all
  end

  def members
    @members = User.all.select{|user| user.member}
  end
end
