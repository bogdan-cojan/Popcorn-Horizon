class Apis::V1::TicketsController < ApplicationController

  def create
    tickets = Ticket.create_tickets_from_selected_seats(ticket_params)

    if tickets.all?(&:persisted?)
      render json: { status: 'Success', message: 'Tickets created.', data: tickets }, status: :created
    else
      render json: { status: 'Error', message: 'Some tickets were not created.', data: tickets.map(&:errors) }, status: :unprocessable_entity
    end
  end

  def find_tickets_by_user
    email = params[:user][:email]
    u = User.find_by(email: email)

    tickets = Ticket.where(user_id: u.id).includes(:movie).map do |ticket|
      {
        id: ticket.id,
        movie_title: ticket.movie.title,
        date: ticket.date,
        time: ticket.time,
        seat: ticket.seat_number
      }
    end

    render json: { status: 'Success', message: 'Tickets found.', data: tickets }, status: :ok
  end

  def find_tickets_by_date_time
    date = params[:date]
    time = params[:time]
  
    tickets = Ticket.where(date: date, time: time).map do |ticket|
      { id: ticket.id, seat: ticket.seat_number }
    end
  
    render json: { status: 'Success', message: 'Tickets found.', data: tickets }, status: :ok
  end

  private

  def ticket_params
    params.require(:ticket).permit(:movieId, :date, :time, seats: [:row, :seat], user: [:email])
  end
end