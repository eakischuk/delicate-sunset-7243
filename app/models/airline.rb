class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def adult_passengers
    passengers.where('passengers.age >= ?', 18)
    .select('passengers.*, COUNT(passengers.*) AS flight_count')
    .group('passengers.id')
    .order('flight_count DESC')
  end
end
