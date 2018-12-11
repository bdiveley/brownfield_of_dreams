class WelcomeController < ApplicationController
  def index
    tutorials = Tutorial.filter_tutorials(current_user)
    if params[:tag]
      @tutorials = tutorials.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = tutorials.paginate(:page => params[:page], :per_page => 5)
    end
  end
end
