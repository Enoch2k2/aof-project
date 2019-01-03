class AddMemberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :member, :boolean
  end
end
