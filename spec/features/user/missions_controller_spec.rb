require 'rails_helper'

feature "User/missions" do
  context 'create new mission' do
    scenario 'creation should be successful' do
      visit new_user_mission_path
      within('form') do
        fill_in I18n.t('mission_title'), with: "Date"
        fill_in I18n.t('mission_contents'), with: "dating with alison around taipei city."
        select "high_priority", from: I18n.t('mission_priority_order')
        select "pending", from: I18n.t('mission_status')
        fill_in I18n.t('mission_initial_time_at'), with: "2020-01-23 08:00".to_datetime
        fill_in I18n.t('mission_finish_time_at'), with: "2020-01-23 22:00".to_datetime
      end
      click_button I18n.t('submit')
      expect(page).to have_content("Create sucessfully!")
    end
  end

  context 'update mission' do
    scenario 'updating should be successful' do
      mission = Mission.find_by title: "Date"
      visit edit_user_mission_path(mission)
      within('form') do
        fill_in I18n.t('mission_initial_time_at'), with: "2020-01-24 08:00".to_datetime
        fill_in I18n.t('mission_finish_time_at'), with: "2020-01-24 22:00".to_datetime
      end
      click_button I18n.t('submit')
      expect(page).to have_content("Update successfully!")
      expect(page).to have_content(Date.parse("2020-01-24 08:00"))
      expect(page).to have_content(Date.parse("2020-01-24 22:00"))
    end
  end

  context 'destroy mission' do
    scenario 'destroy should be sucessful', js: true do
      mission = Mission.find_by title: "Date"
      visit user_mission_path(mission)
      page.accept_alert do
        click_link I18n.t("destroy_mission")
      end
      expect(page).to have_content("Destroy successfully!")
    end
  end

  context 'check order of missions with created_time' do
    let!(:mission1) { create(:mission1) }
    let!(:mission2) { create(:mission2) }
    before(:each) { visit user_missions_path }
    scenario 'should be correct' do
      expect(page.body.index(mission1.title)).to be < page.body.index(mission2.title)
    end

    scenario 'should be incorrect' do
      expect(page.body.index(mission1.title)).not_to be > page.body.index(mission2.title)
    end
  end
end
