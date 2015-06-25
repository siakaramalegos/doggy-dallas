class Dog < ActiveRecord::Base
  belongs_to :owner
  belongs_to :breed

  validates :name, :owner_id, presence: true

  has_attached_file :avatar,
    :styles => {
      :medium => "300x300#",
      :thumb => "75x75#" },
    :default_url => ":style_missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :less_than => 3.megabytes,
    :unless => Proc.new {|m| m[:avatar_file_name].blank?}
end
