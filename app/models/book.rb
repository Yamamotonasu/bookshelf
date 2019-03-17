class Book < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  attribute :new_image
  # 本の情報が削除されたらそれに関連するレビューも削除されなければならない。
  # その関連付けを行う。
  has_many :reviews, dependent: :destroy

  #Bookモデルからレビューした人のユーザー情報を取ってくる時にレビューを介してユーザーの情報を取ってくる事を明示する
  has_many :users, through: :reviews

  validates :title, presence: true, length: { maximum: 50 }
  validates :price, presence: true,
    numericality: {
      only_integer: true, #integerのみ
      greater_than: 1 # 1文字以上のみ
    }
  validates :publish_date, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  scope :find_newest_books, -> (p) { page(p).per(4).order(publish_date: :desc) }


  # バリデーションチェックで引っかからなかった場合にDBにセーブする前に保存される
  before_save do
    self.image = new_image if new_image
  end
end
