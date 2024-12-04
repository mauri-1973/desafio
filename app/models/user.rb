class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy  # Añade esta línea
  has_many :liked_posts, through: :likes, source: :post  # También debe estar presente

  enum role: { user: 0, moderator: 1, admin: 2 }

  before_create :set_default_role

  def set_default_role
    self.role ||= :user
  end
  
end
