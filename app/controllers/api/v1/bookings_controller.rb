class Api::V1::BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :check_payload, only: %i[create update]

  def index
    bookings = Booking.all.order(:created_at)
    render json: bookings, status: :ok
  end


  def show
    #nothing here
  end

  def new
    @booking = Booking.new
  end


  def edit
    #nothing here
  end

  def create
    booking = Booking.new(booking_params.merge(check_payload))

    if booking.save
      render json: booking, status: :ok
    else
      render json: booking.errors, status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(booking_params)
      render json: @booking, status: :ok
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
  end

  private

  def set_booking
    @booking = booking.find(params[:id])
  end

  def booking_params
    params.permit(:reservation_code, :start_date, :end_date, :nights, :guests, :adults, :children, :infants, :localized_description, :status, :guest_first_name, :guest_last_name, :guest_email, :currency, :payout_price, :security_price, :total_price, guest_phone: [])
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

end
