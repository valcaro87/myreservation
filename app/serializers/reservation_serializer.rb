class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :reservation_code, :start_date, :end_date, :nights, :guests, :adults, :children, :infants, :localized_description, :status, :currency, :payout_price, :security_price, :total_price, :guest

  def guest
    {
      id: object.guest.id,
      first_name: object.guest.first_name,
      last_name: object.guest.last_name,
      phone: object.guest.phone,
    }
  end

end
