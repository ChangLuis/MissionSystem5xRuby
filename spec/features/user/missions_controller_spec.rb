require 'rails_helper'

feature "User/missions" do
  context 'Create new mission' do
    scenario 'creation should be successful' do
      visit new_user_mission_path
      within('form') do
        fill_in t('activerecord.attributes.mission.title'), with: "Date"
        fill_in t('activerecord.attributes.mission.contents'), with: "dating with alison around taipei city."
        select "high_priority", from: t('activerecord.attributes.mission.priority_order')
        select "pending", from: t('activerecord.attributes.mission.status')
        fill_in t('activerecord.attributes.mission.initial_time_at'), with: "2020-01-23 08:00".to_datetime
        fill_in t('activerecord.attributes.mission.finish_time_at'), with: "2020-01-23 22:00".to_datetime
      end
      click_button t('submit')
      expect(page).to have_content(t('mission.create.notice'))
    end
  end

  context 'Update mission' do
    scenario 'updating should be successful' do
      mission = Mission.find_by title: "Date"
      visit edit_user_mission_path(mission)
      within('form') do
        fill_in t('activerecord.attributes.mission.initial_time_at'), with: "2020-01-24 08:00".to_datetime
        fill_in t('activerecord.attributes.mission.finish_time_at'), with: "2020-01-24 22:00".to_datetime
      end
      click_button t('submit')
      expect(page).to have_content(t('mission.edit.notice'))
      expect(page).to have_content(Date.parse("2020-01-24 08:00"))
      expect(page).to have_content(Date.parse("2020-01-24 22:00"))
    end
  end

  context 'Destroy mission' do
    scenario 'destroy should be sucessful', js: true do
      mission = Mission.find_by title: "Date"
      visit user_mission_path(mission)
      page.accept_alert do
        click_link t("mission.destroy.btn")
      end
      expect(page).to have_content(t('mission.destroy.notice'))
    end
  end

  describe 'Check order logic of missions' do
    let!(:mission1) { create(:mission1) }
    let!(:mission2) { create(:mission2) }
    before(:each) { visit user_missions_path }

    context 'with created_time' do
      scenario 'should be correct' do
        expect(body.index(mission1.title)).to be < body.index(mission2.title)
      end

      scenario 'should be incorrect' do
        expect(body.index(mission1.title)).not_to be > body.index(mission2.title)
      end
    end

    context 'with finish_time' do
      before(:each) { click_link t('mission.finish_time_at') }
      scenario 'should be correct' do
        expect(body.index(mission1.title)).to be > body.index(mission2.title)
      end

      scenario 'should be incorrect' do
        expect(body.index(mission1.title)).not_to be < body.index(mission2.title)
      end
    end
  end
end
