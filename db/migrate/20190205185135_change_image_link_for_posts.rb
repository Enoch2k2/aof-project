class ChangeImageLinkForPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :image_link, :image_url
  end
end
