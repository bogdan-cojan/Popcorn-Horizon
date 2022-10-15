class ChangeRatingColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :rating, :decimal, :precision => 2, :scale => 1
  end
end
