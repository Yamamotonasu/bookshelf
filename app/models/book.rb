class Book < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  attribute :new_image

  validates :title, presence: true, length: { maximum: 50 }
  validates :price, presence: true,
    numericality: {
      only_integer: true, #integerのみ
      greater_than: 1 # 1文字以上のみ
    }
  validates :publish_date, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  # バリデーションチェックで引っかからなかった場合にDBにセーブする前に保存される
  before_save do
    self.image = new_image if new_image
  end
end
