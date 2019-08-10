module Admin
  class TicketsController < ApplicationController
    before_action :ensure_admin
    before_action :ensure_superuser, only: :destroy

    def index
      @tickets = Ticket.includes(:user).order(:created_at)
    end

    def show
      @ticket = Ticket.includes(:user).find(params[:id])
    rescue
      not_found
    end

    def create
      ticket = current_user.tickets.create(note: 'Mock Ticket')
      flash[:notice] = "Ticket has been created!!!"
      redirect_to admin_ticket_url(ticket)
    end

    def claim
      @ticket = Ticket.includes(:user).find_by!(claim_token: params['claim_token'])
    rescue
      not_found
    end

    def redeem
      @ticket = Ticket.includes(:user).find_by!(claim_token: params[:claim_token])

      raise ArgumentError if @ticket.claimed?

      @ticket.claimed_at = DateTime.current
      @ticket.claimed_by = current_user.username
      @ticket.save

      flash[:notice] = "Ticket has been redeemed"
      redirect_to admin_ticket_url(@ticket)
    rescue
      not_found
    end

    def destroy
      @ticket = Ticket.find(params[:id])
      @ticket.destroy
      redirect_to admin_tickets_url, notice: 'Ticket was successfully destroyed.'
    end
  end
end