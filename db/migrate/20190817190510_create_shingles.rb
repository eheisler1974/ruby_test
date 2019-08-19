class CreateShingles < ActiveRecord::Migration[5.1]
  def change
    create_table :shingles do |t|
      t.string :line
      t.string :color
      t.string :url

      t.timestamps
    end
  end
end
