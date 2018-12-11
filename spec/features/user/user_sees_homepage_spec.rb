require 'rails_helper'

describe 'User' do
  describe 'on the home page' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @tutorial1 = create(:tutorial, classroom: true, tag_list: ["BDD"])
      @tutorial2 = create(:tutorial, classroom: false, tag_list: ["BDD"])
      @video1 = create(:video, tutorial_id: @tutorial1.id)
      @video2 = create(:video, tutorial_id: @tutorial1.id)
      @video3 = create(:video, tutorial_id: @tutorial2.id)
      @video4 = create(:video, tutorial_id: @tutorial2.id)

      visit root_path
    end
      it 'can see a list of all tutorials' do
      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(@tutorial2.title)
        expect(page).to have_content(@tutorial2.description)
        expect(page).to have_content(@tutorial1.title)
        expect(page).to have_content(@tutorial1.description)
      end
    end
    it 'can filter the tutorials' do
      click_on "BDD"

      expect(page).to have_content(@tutorial1.title)
      expect(page).to have_content(@tutorial2.title)
    end
  end
end
