class CreateNewsPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :news_posts do |t|
      t.date :date
      t.string :title
      t.string :content
      t.string :image_url

      t.timestamps
    end
  end
end
