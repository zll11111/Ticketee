require 'rails_helper'

RSpec.feature "Admins can create new state for tickets" do

  before do
    login_as(FactoryGirl.create(:user,:admin))
  end
  scenario "with valid details" do

    visit admin_root_path
    click_link "States"
    click_link "New State"

    fill_in "Name",with:"Won't fix"
    fill_in "Color",with: "Orange"
    click_button "Create State"
    expect(page).to have_content "State has been created."
  end
end