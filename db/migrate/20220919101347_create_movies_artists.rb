class CreateMoviesArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :movies_artists, id: false do |t|
      t.belongs_to :movie
      t.belongs_to :artist
    end
  end
end
