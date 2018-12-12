namespace :video_position do
  desc "This will run through the whole database and change the videos position if they're nil"
  task correct_nil: :environment do
      puts "rake task start"
    Video.where(position: 0).each do |video|
      number = video.tutorial.videos.count
      video.update(position: number)
    end
    puts "rake task end"
  end

end
