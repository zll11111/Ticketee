require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:project) {FactoryGirl.create(:project)}
  let(:user) {FactoryGirl.create(:user)}

  before do
    assign_role!(user,:editor,project)
    sign_in user
  end

  it "can create tickets ,but not tag them" do
    post :create,ticket: {name:"New ticket",description: "new new",tag_names: "no tags"},project_id: project.id
    expect(ticket.last.tags).to be_empty
  end
end
