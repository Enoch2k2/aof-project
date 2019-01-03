class WelcomeController < ApplicationController
  def index
    @news = NewsPost.all
  end
end
