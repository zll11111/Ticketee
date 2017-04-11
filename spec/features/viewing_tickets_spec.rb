require "rails_helper"

RSpec.feature "User can view tickets" do
  before do
    auther = FactoryGirl.create(:user)
    sublime = FactoryGirl.create(:project,name:"Sublime Text 3")
    assign_role!(auther,:viewer,sublime)
    FactoryGirl.create(:ticket,project:sublime,auther: auther,name:"Make it shiny!",description:"Gradients! Starbursts! Oh my!")

    # ie = FactoryGirl.create(:project,name:"Internet Explorer")
    # assign_role!(auther,:viewer,ie)
    # FactoryGirl.create(:ticket,project:ie,auther: auther,name:"Standards compliance",description:"Isn't a joke.")
    login_as(auther)
    visit "/"
  end

  scenario "for a given project" do
    click_link "Sublime Text 3"
    expect(page).to have_content "Make it shiny!"
    expect(page).to_not have_content "Standards compliance"

    click_link "Make it shiny!"
    within("#ticket h2") do
      expect(page).to have_content "Make it shiny!"
    end

    expect(page).to have_content "Gradients! Starbursts! Oh my!"
  end
end