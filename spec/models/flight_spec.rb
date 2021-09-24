require 'rails_helper'

RSpec.describe Flight do
  before(:each) do
    @fronteir = Airline.create!(name: 'Fronteir')
    @southwest = Airline.create!(name: 'Southwest')

    @steve = Passenger.create!(name: 'Steve', age: 52)
    @meg = Passenger.create!(name: 'Meg', age: 34)
    @albert = Passenger.create!(name: 'Albert', age: 79)
    @ally = Passenger.create!(name: 'Ally', age: 13)

    @flight_1 = Flight.create!(number: 1, date: '08/03/21', departure_city: 'Denver', arrival_city: 'Portland', airline: @fronteir)
    @flight_2 = Flight.create!(number: 2, date: '08/15/21', departure_city: 'Indianapolis', arrival_city: 'San Francisco', airline: @southwest)

    @flight_1_steve = FlightPassenger.create!(flight: @flight_1, passenger: @steve)
    @flight_1.passengers << @ally
    @flight_1.passengers << @meg

    @flight_2_albert = FlightPassenger.create!(flight: @flight_2, passenger: @albert)
    @flight_2.passengers << @steve
  end
  describe 'relationships' do
    it { should belong_to(:airline) }
    it { should have_many(:flight_passengers) }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'instance methods' do
    it 'returns flight passenger for given passenger' do
      expect(@flight_1.flight_passenger(@steve.id)).to eq(@flight_1_steve)
      expect(@flight_2.flight_passenger(@albert.id)).to eq(@flight_2_albert)
    end
  end
end
