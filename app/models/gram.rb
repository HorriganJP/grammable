class Gram < ApplicationRecord
  validates :message, presence: true
  validates :image, presence: true


  mount_uploader :image, ImageUploader
  mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :comments
end
