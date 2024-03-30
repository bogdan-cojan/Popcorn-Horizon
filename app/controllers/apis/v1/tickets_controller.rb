class Apis::V1::TicketsController < ApplicationController

  def create
    tickets = Ticket.create_tickets_from_selected_seats(ticket_params)

    if tickets.all?(&:persisted?)
      render json: { status: 'Success', message: 'Tickets created.', data: tickets }, status: :created
    else
      render json: { status: 'Error', message: 'Some tickets were not created.', data: tickets.map(&:errors) }, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:movieId, :date, :time, seats: [:row, :seat], user: [:email])
  end
end