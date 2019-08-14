class Gram < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :message, length: { minimum: 2 }

  belongs_to :user
end
