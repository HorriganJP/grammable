class Gram < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :picture, PictureUploader
  validates :message, length: { minimum: 2 }

  belongs_to :user
end
