class Movie < ApplicationRecord
  has_and_belongs_to_many :artists, join_table: "movies_artists"
  has_one_attached :image, :dependent => :destroy
  has_many :tickets, :dependent => :destroy
end
