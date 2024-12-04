class AddTitleAndImageToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :title, :string
    add_column :posts, :image, :string
  end
end
