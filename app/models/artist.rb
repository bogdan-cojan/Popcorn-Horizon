class Artist < ApplicationRecord
  has_and_belongs_to_many :movies, join_table: "movies_artists"
end
