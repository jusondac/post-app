class AddPublisherToPosts < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :publisher, null: true, foreign_key: true
  end
end
