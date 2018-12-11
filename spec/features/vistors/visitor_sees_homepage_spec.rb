require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    before(:each) do
      @tutorial1 = create(:tutorial, classroom: true, tag_list: ["BDD"])
      @tutorial2 = create(:tutorial, classroom: false, tag_list: ["BDD"])

      @video1 = create(:video, tutorial_id: @tutorial1.id)
      @video2 = create(:video, tutorial_id: @tutorial1.id)
      @video3 = create(:video, tutorial_id: @tutorial2.id)
      @video4 = create(:video, tutorial_id: @tutorial2.id)

      visit root_path
    end
      it 'can see a list of tutorials that are not classroom_content tutorials' do
      expect(page).to have_css('.tutorial', count: 1)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(@tutorial2.title)
        expect(page).to have_content(@tutorial2.description)
        expect(page).not_to have_content(@tutorial1.title)
        expect(page).not_to have_content(@tutorial1.description)
      end
    end
    it 'can see a list of tutorials that are not classroom_content and filtered by tags' do
      click_on "BDD"

      expect(page).to have_content(@tutorial2.title)
      expect(page).not_to have_content(@tutorial1.title)
    end
  end
end
