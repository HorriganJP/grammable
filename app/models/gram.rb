class Gram < ApplicationRecord
  validates :message, length: { minimum: 2 }

  belongs_to :user
end
