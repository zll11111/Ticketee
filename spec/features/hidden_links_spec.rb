require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do

  let(:user){FactoryGirl.create(:user)}
  let(:admin){FactoryGirl.create(:user,:admin)}
  let(:project){FactoryGirl.create(:project)}
  let(:ticket){FactoryGirl.create(:ticket,project:project,auther:user)}
  context "anonymous users" do
    scenario 'cannot see the New Project link' do

      visit "/"
      expect(page).not_to have_link "New Project"
    end

=begin
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
=end
  end

  context "regular users" do
    before {login_as(user)}
    scenario 'cannot see the New Project link' do

      visit "/"
      expect(page).not_to have_link "New Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Edit Project"
    end

    scenario "cannot see the New Ticket link" do
      visit project_path(project)
      expect(page).not_to have_link "New Ticket"
    end

    scenario "cannot see the Edit Ticket link" do
      visit project_ticket_path(project,ticket)
      expect(page).not_to have_link "Edit Ticket"
    end

    scenario "cannot see the Delete Ticket link" do
      visit project_ticket_path(project,ticket)
      expect(page).not_to have_link "Delete Ticket"
    end
=begin
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
=end
  end

  context "admin users" do
    before {login_as(admin)}

    scenario 'can see the New Project link' do

      visit "/"
      expect(page).to have_link "New Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end

    scenario "can see the Edit Project link" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end

    scenario "can see the New Ticket link" do
      visit project_path(project)
      expect(page).to have_link "New Ticket"
    end


    scenario "can see the Edit Ticket link" do
      visit project_ticket_path(project,ticket)
      expect(page).to have_link "Edit Ticket"
    end

    scenario "can see the Delete Ticket link" do
      visit project_ticket_path(project,ticket)
      expect(page).to have_link "Delete Ticket"
    end
  end



end