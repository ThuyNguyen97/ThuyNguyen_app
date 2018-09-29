class Micropost < ApplicationRecord
  MICROPOST_ATTRS = %w(content picture).freeze

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.length.max_content}
  validate :picture_size

  default_scope ->{order(created_at: :desc)}

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.length.max_content}
  validate  :picture_size

  private

  def picture_size
    errors.add :picture, t("image_alert") if picture.size > 5.megabytes
  end
end
