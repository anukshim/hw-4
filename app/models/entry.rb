class Entry < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_one_attached :image
end
