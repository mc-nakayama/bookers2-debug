class Group < ApplicationRecord
  has_many :users, through: :group_users
  has_many :group_users
  # 他のモデルを一括で更新・保存か可能になるオプション
  accepts_nested_attributes_for :group_users

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50 }

  has_one_attached :image

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

end
