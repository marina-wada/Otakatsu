class PostImage < ApplicationRecord
  belongs_to :item
  has_many_attached :images
end
