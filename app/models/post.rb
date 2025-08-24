class Post < ApplicationRecord
  belongs_to :user
  belongs_to :publisher, optional: true

  enum :status, { draft: 0, published: 1 }

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :user, presence: true

  # Only users with 'user' role can create posts
  validate :user_can_create_post

  scope :by_user, ->(user) { where(user: user) }

  def self.ransackable_associations(auth_object = nil)
    [ "publisher", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "content", "created_at", "id", "publisher_id", "status", "title", "updated_at", "user_id" ]
  end


  private

  def user_can_create_post
    return unless user

    unless user.user?
      errors.add(:user, "must have 'user' role to create posts")
    end
  end
end
