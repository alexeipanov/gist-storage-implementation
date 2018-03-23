class AddPrivateToFragments < ActiveRecord::Migration[5.1]
  def change
    add_column :fragments, :private, :boolean
  end
end
