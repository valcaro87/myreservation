class Api::V1::ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_reservation, only: %i[show edit update destroy]
  before_action :set_guest, only: %i[create]
  before_action :check_payload, only: %i[create update]

  def index
    reservations = Reservation.all.order(:created_at)
    render json: reservations, status: :ok
  end


  def show
    render json: @reservation, status: :ok
  end

  def new
    @reservation = Reservation.new
  end


  def edit
    #nothing here
  end

  def create
    reservation = @guest.reservations.new(reservation_params.merge(check_payload))
    if Reservation.where(reservation_code: reservation.reservation_code, guest_email: @guest.email)&.size >= 1
      render json: {status: "Reservation code and email already exist"}, status: :forbidden
    else
      if reservation.save
        render json: reservation, status: :ok
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if @reservation.update(reservation_params.merge(check_payload))
      render json: @reservation, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.permit(:reservation_code, :start_date, :end_date, :nights, :guests, :adults, :children, :infants, :localized_description, :status, :guest_first_name, :guest_last_name, :guest_email, :currency, :payout_price, :security_price, :total_price, :guest_id, guest_phone: [])
  end

  def check_payload
    if params[:reservation_code].present?
      {
        guest_first_name: params[:guest][:first_name],
        guest_last_name: params[:guest][:last_name],
        guest_email: params[:guest][:email],
        guest_phone: params[:guest][:phone].split(','),
      }
    else
      {
        reservation_code: params[:reservation][:code],
        start_date: params[:reservation][:start_date],
        end_date: params[:reservation][:end_date],
        nights: params[:reservation][:nights],
        guests: params[:reservation][:number_of_guests],
        localized_description: params[:reservation][:guest_details][:localized_description],
        adults: params[:reservation][:guest_details][:number_of_adults],
        children: params[:reservation][:guest_details][:number_of_children],
        infants: params[:reservation][:guest_details][:number_of_infants],
        guest_first_name: params[:reservation][:guest_first_name],
        guest_last_name: params[:reservation][:guest_last_name],
        guest_email: params[:reservation][:guest_email],
        guest_phone: params[:reservation][:guest_phone_numbers].split(','),
        currency: params[:reservation][:host_currency],
        payout_price: params[:reservation][:expected_payout_amount],
        security_price: params[:reservation][:listing_security_price_accurate],
        status: params[:reservation][:status_type],
        total_price: params[:reservation][:total_paid_amount_accurate],
      }
    end
  end

  def set_guest
    guest_email = if params[:guest].present?
      params[:guest][:email].try(:downcase)
    elsif params[:reservation][:guest_email].present?
      params[:reservation][:guest_email].try(:downcase)
    else
      nil
    end

    if guest_email
      guest = Guest.find_by_email(guest_email)
      if guest.present?
        @guest = guest
      else
        @guest = Guest.create(email: guest_email)
      end
    end
  end

end
