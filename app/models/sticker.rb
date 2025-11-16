class Sticker < ApplicationRecord
  has_many :shops, dependent: :destroy
end
