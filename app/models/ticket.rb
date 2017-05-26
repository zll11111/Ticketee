class Ticket < ActiveRecord::Base
  attr_accessor :tag_names

  belongs_to :project
  belongs_to :auther,class_name:"User"
  belongs_to :state
  validates :name,presence: true
  validates :description,presence: true,length:{minimum:10}

  has_many :attachments,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_and_belongs_to_many :tags,uniq: true
  accepts_nested_attributes_for :attachments,reject_if: :all_blank

  before_create :assgin_default_state
  #mount_uploader :attachment,AttachmentUploader
  #mount_uploader :attachment, AttachmentUploader

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end
  private

  def assgin_default_state
    self.state ||= State.default
  end


end
