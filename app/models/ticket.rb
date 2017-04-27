class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :auther,class_name:"User"
  validates :name,presence: true
  validates :description,presence: true,length:{minimum:10}

  has_many :attachments,dependent: :destroy
  accepts_nested_attributes_for :attachments,reject_if: :all_blank
  #mount_uploader :attachment,AttachmentUploader
  #mount_uploader :attachment, AttachmentUploader
end
