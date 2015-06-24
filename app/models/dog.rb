class Dog < ActiveRecord::Base
  belongs_to :owner
  belongs_to :breed

  validates :name, :owner_id, presence: true

  has_attached_file :avatar,
    :styles => {
      :medium => "300x300#",
      :thumb => "75x75#" },
    :default_url => "/images/:style_missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
