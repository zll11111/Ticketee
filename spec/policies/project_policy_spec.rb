require 'rails_helper'

RSpec.describe ProjectPolicy do

  let(:user) { User.new }

  subject { ProjectPolicy }

  context "policy_scope" do
    subject {Pundit.policy_scope(user,Project)}
    let(:user){FactoryGirl.create(:user)}
    let(:project){FactoryGirl.create(:project)}

    it "is empty for anonymous users" do
      expect(Pundit.policy_scope(nil,Project)).to be_empty
    end

    it "includes projects a user is allowed to view" do
      assign_role!(user,:viewer,project)
      expect(subject).to include(project)
    end

    it "doesn't include projects a user is not allowed to view" do
      expect(subject).to be_empty
    end

    it "returns all projects for admin" do
      user.admin = true
      expect(subject).to include(project)
    end
  end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

=begin
  permissions :show? do
    let(:user){FactoryGirl.create :user}
    let(:project){FactoryGirl.create :project}

    it "block anonymous users" do
      # puts subject.new(user,project).show?
      expect(subject).not_to permit(nil,project)
    end

    it "block viewers of the project" do
      assign_role!(user,:viewer,project)
      expect(subject).to permit(user,project)
    end

    it "allows editors of the project" do
      assign_role!(user,:editor,project)
      expect(subject).to permit(user,project)

    end

    it "allows managers of the project" do
      assign_role!(user,:manager,project)
      expect(subject).to permit(user,project)
    end

    it "allows administrator" do
      admin = FactoryGirl.create(:user,:admin)

      expect(subject).to permit(admin,project)
    end

    it "doesn't allow users assigned to other projects" do
      other_project = FactoryGirl.create :project
      assign_role!(user,:manager,other_project)
      expect(subject).not_to permit(user,project)
    end
  end

  permissions :update? do
    let(:user){FactoryGirl.create :user}
    let(:project){FactoryGirl.create :project}

    it "block anonymous users" do
      expect(subject).not_to permit(nil,project)
    end

    it "block viewers of the project" do
      assign_role!(user,:viewer,project)
      expect(subject).not_to permit(user,project)
    end

    it "allows editors of the project" do
      assign_role!(user,:editor,project)
      expect(subject).not_to permit(user,project)

    end

    it "allows managers of the project" do
      assign_role!(user,:manager,project)
      expect(subject).to permit(user,project)
    end

    it "allows administrator" do
      admin = FactoryGirl.create(:user,:admin)

      expect(subject).to permit(admin,project)
    end

    it "doesn't allow users assigned to other projects" do
      other_project = FactoryGirl.create :project
      assign_role!(user,:manager,other_project)
      expect(subject).not_to permit(user,project)
    end
  end
=end

  context "permissions" do
    subject{ProjectPolicy.new(user,project)}

    let(:user){FactoryGirl.create(:user)}
    let(:project){FactoryGirl.create(:project)}

    context "for anonyous users" do
      let(:user){nil}

      it{should_not permit_action :show}
      it{should_not permit_action :update}
      #it{should_not permit_action :destroy}
    end

    context "for viewers of the project" do
      before {assign_role!(user,:viewer,project)}

      it{should permit_action :show}
      it{should_not permit_action :update}
      #it{should_not permit_action :destroy}
    end

    context "for editors of the project" do
      before {assign_role!(user,:editor,project)}

      it{should permit_action :show}
      it{should_not permit_action :update}
      #it{should_not permit_action :destroy}
    end

    context "for managers of the project" do
      before { assign_role!(user, :manager, project) }
      it { should permit_action :show }
      it { should permit_action :update }
      ##it{should permit_action :destroy}
    end
    context "for managers of other projects" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:project))
      end
      it { should_not permit_action :show }
      it { should_not permit_action :update }
      #it{should_not permit_action :destroy}
    end
    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }
      it { should permit_action :show }
      it { should permit_action :update }
      #it{should permit_action :destroy}
    end
  end

  #
  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
