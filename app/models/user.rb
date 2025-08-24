class User < ApplicationRecord
  # email	string
  # encrypted_password	string
  # reset_password_token	string
  # reset_password_sent_at	datetime
  # remember_created_at	datetime
  # role	integer
  # index	email,reset_password_token
  #

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { user: 0, admin: 1, master: 2 }

  has_many :posts, dependent: :destroy

  # Only users with 'user' role can create posts
  def can_create_posts?
    user?
  end

  # Only admins and masters can manage publishers
  def can_manage_publishers?
    admin? || master?
  end

  def can_see_publisher?
    user? || master?
  end

  def can_manage_users?
    master?
  end

  def can_access_authorization?
    master?
  end
end
