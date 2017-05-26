class Comment < ActiveRecord::Base

  attr_accessor :tag_names
  belongs_to :ticket
  belongs_to :auther, class_name: "User"
  belongs_to :state
  belongs_to :previous_state, class_name: "State"
  validates :text, presence: true

  delegate :project, to: :ticket

  scope :persisted, lambda { where.not(id: nil) }

  before_create :set_previous_state
  after_create :set_ticket_state
  after_create :associate_tags_with_ticket
  private
  def set_ticket_state
    ticket.state = state
    ticket.save!
  end

  def set_previous_state
    previous_state = ticket.state
  end

  def associate_tags_with_ticket
    if tag_names
      ticket.tag_names = tag_names
    end

  end
end
