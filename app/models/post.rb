class Post < ActiveRecord::Base
  has_attached_file :picture, styles: { medium: "600x600>" }
  # Validate content type
  validates_attachment_content_type :picture, content_type: /\Aimage/
  # Validate filename
  validates_attachment_file_name :picture, matches: [/png\z/, /jpe?g\z/]
  validates :title, presence: true
  validates :picture, attachment_presence: true
  belongs_to :user
end
