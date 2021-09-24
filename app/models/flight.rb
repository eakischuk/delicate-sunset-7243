class Flight < ApplicationRecord
  belongs_to :airline
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  def flight_passenger(passenger_id)
    flight_passengers.where('passenger_id = ?', passenger_id).first
  end
end
