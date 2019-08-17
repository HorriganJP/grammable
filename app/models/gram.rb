class Gram < ApplicationRecord
  validates :message, length: { minimum: 2 }
  validates :picture, presence: true


  mount_uploader :image, ImageUploader
  mount_uploader :picture, PictureUploader

  belongs_to :user
end
