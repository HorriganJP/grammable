class Gram < ApplicationRecord
  validates :message, length: { minimum: 2 }
end
