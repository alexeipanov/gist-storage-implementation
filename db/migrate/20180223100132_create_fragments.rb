class CreateFragments < ActiveRecord::Migration[5.1]
  def change
    create_table :fragments do |t|
      t.text :value, limit: 8192

      t.timestamps
    end
  end
end
