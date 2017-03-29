require 'rails_helper'

RSpec.feature 'Users can create new tickets' do

  before do
    project = FactoryGirl.create(:project,name:"Internet Explorer")

    visit project_url(project)
    click_link "New Ticket"
  end

  scenario 'with valid attributes' do

    fill_in "Name",with:"Non-standards compliance"
    fill_in "Description",with:"My pages are ugly!"

    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
  end


  scenario 'with invalid attributes' do


    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "with an invalid description" do
    fill_in "Name",with:"Non-standards comliance"
    fill_in "Description",with:"it sucks"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end

end