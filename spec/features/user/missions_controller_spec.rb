require 'rails_helper'

feature "User/missions" do
  describe 'After user login' do
    let!(:user) { create(:user) }
    before(:each) do
      page.set_rack_session(user_id: user.id)
    end

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
      let!(:mission) { create(:mission_date) }
      scenario 'updating should be successful' do
        visit edit_user_mission_path(mission)
        within('form') do
          fill_in t('activerecord.attributes.mission.initial_time_at'), with: "2020-01-24 08:00".to_datetime
          fill_in t('activerecord.attributes.mission.finish_time_at'), with: "2020-01-24 22:00".to_datetime
        end
        click_button t('submit')
        expect(page).to have_content(t('mission.edit.notice'))
      end
    end

    context 'Destroy mission' do
      let!(:mission) { create(:mission_date) }
      scenario 'destroy should be sucessful', js: true do
        visit user_mission_path(mission)
        page.accept_alert do
          click_link t("mission.destroy.btn")
        end
        expect(page).to have_content(t('mission.destroy.notice'))
      end
    end

    describe 'Check order logic of missions' do
      let!(:mission1) { create(:mission_date) }
      let!(:mission2) { create(:mission_meeting) }
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

      context 'with priority_order' do
        before(:each) { click_link t('mission.priority_order') }

        scenario 'should be correct' do
          expect(body.index(mission1.title)).to be < body.index(mission2.title)
        end

        scenario 'should be incorrect' do
          expect(body.index(mission1.title)).not_to be > body.index(mission2.title)
        end
      end
    end

    describe 'Check search index' do
      let!(:mission) { create(:mission_meeting) }
      before(:each) { visit user_missions_path }

      context 'Search with title of mission' do
        scenario 'should be correct' do
          fill_in t('activerecord.attributes.mission.title'), with: "m"
          click_button t('submit_with_search')
          expect(page).to have_content("Meeting")
        end

        scenario 'should be incorrect' do
          fill_in t('activerecord.attributes.mission.title'), with: "D"
          click_button t('submit_with_search')
          expect(page).not_to have_content("Meeting")
        end
      end

      context 'Search with status of mission' do
        scenario 'should be correct' do
          select "pending", from: t('activerecord.attributes.mission.status')
          click_button t('submit_with_search')
          expect(page).to have_content("Meeting")
        end

        scenario 'should be incorrect' do
          select "finish", from: t('activerecord.attributes.mission.status')
          click_button t('submit_with_search')
          expect(page).not_to have_content("Meeting")
        end
      end
    end
  end
end
