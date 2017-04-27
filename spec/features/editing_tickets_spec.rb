require "rails_helper"

RSpec.feature "Users can edit existing tickets" do
  let(:auther){FactoryGirl.create(:user)}
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project,auther: auther) }

  before do
    assign_role!(auther,:editor,project)
    login_as(auther)
    visit project_ticket_path(project, ticket)
    click_link "Edit Ticket"
  end

  scenario "with valid attribute" do
    fill_in "Name", with: "Make it really shiny!"
    click_button "Update Ticket"
    expect(page).to have_content "Ticket has been updated."
    within("#ticket h2") do
      expect(page).to have_content "Make it really shiny!"
      expect(page).not_to have_content ticket.name
    end
  end

  scenario "with invalid attribute" do
    fill_in "Name",with:""
    click_button "Update Ticket"
    expect(page).to have_content "Ticket has not been updated."
  end
end