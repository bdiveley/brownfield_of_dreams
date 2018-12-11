class TutorialsController < ApplicationController
  def show
    filtered_tutorials = Tutorial.filter_tutorials(current_user)

    tutorial = filtered_tutorials.find do |tutorial|
      tutorial.id == params[:id].to_i
    end

    if tutorial
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      redirect_to root_path
    end
  end
end
