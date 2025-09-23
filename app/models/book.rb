class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  # ===== Validation =====
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end