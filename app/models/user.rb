class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  scope :members, -> { User.all.select{|user| user.member} }

  has_many :posts

  def latest_posts
    posts.last(5)
  end
end
