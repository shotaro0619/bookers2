class Book < ApplicationRecord
is_impressionable counter_cache: true
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end



end
