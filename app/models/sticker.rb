class Sticker < ApplicationRecord
  has_many :shops, dependent: :destroy
  has_many :checks, dependent: :destroy
end
