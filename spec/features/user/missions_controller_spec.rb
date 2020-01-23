require 'rails_helper'

feature "User/missions" do
  context 'create new mission' do
    scenario 'creation should be successful' do
      visit new_user_mission_path
      within('form') do
        fill_in 'Title', with: "Date"
        fill_in 'Contents', with: "dating with alison around taipei city."
        select "high_priority", from: 'Priority order'
        select "pending", from: 'Status'
        fill_in 'Initial time at', with: "2020-01-23 08:00".to_datetime
        fill_in 'Finish time at', with: "2020-01-23 22:00".to_datetime
      end
      click_button 'Create Mission'
      expect(page).to have_content("Create sucessfully!")
    end
  end

  context 'update mission' do
    scenario 'updating should be successful' do
      mission = Mission.find_by title: "Date"
      visit edit_user_mission_path(mission)
      within('form') do
        fill_in 'Initial time at', with: "2020-01-24 08:00".to_datetime
        fill_in 'Finish time at', with: "2020-01-24 22:00".to_datetime
      end
      click_button 'Update Mission'
      expect(page).to have_content("Update successfully!")
      expect(page).to have_content(Date.parse("2020-01-24 08:00"))
      expect(page).to have_content(Date.parse("2020-01-24 22:00"))
    end
  end

  context 'destroy mission' do
    scenario 'destroy should be sucessful' do
      mission = Mission.find_by title: "Date"
      visit user_mission_path(mission)
      page.accept_alert do
        click_link 'remove the mission'
      end
      expect(page).to have_content("Destroy successfully!")
    end
  end
end
