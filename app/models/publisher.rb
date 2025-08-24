class Publisher < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 500 }

  has_many :posts, dependent: :nullify

  scope :active, -> { where(active: true) }

  def self.ransackable_attributes(auth_object = nil)
    [ "active", "created_at", "description", "id", "name", "updated_at" ]
  end
end
