class TutorialsController < ApplicationController
  def show
    filtered_tutorials = Tutorial.filter_tutorials(current_user)
    if !filtered_tutorials.empty? &&  current_user
      tutorial = filtered_tutorials.find(params[:id])
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      redirect_to root_path
    end
  end
end
