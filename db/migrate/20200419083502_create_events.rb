class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.text :note
      t.date :date
      t.string :location
      t.string :gather_location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
