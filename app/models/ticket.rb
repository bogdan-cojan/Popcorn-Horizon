class Ticket < ApplicationRecord
  belongs_to :movie
  belongs_to :user, optional: true

  def self.create_tickets_from_selected_seats(params)
    user = User.find_by(email: params[:user][:email])
        
    params[:seats].map do |seat|
      row_number = seat[:row]
      seat_number = seat[:seat]
      seat_id = "R#{row_number}-S#{seat_number}"
      Ticket.create(movie_id: params[:movieId], date: params[:date], time: params[:time], seat_number: seat_id, user_id: user.id || nil)
    end
  end
end
