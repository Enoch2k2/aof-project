class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def valid_comments
    comments.where('id IS NOT ?', nil)
  end
end
