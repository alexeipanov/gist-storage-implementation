class AddUrlToFragments < ActiveRecord::Migration[5.1]
  def change
    add_column :fragments, :url, :string
  end
end
