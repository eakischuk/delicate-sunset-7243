require 'rails_helper'

RSpec.describe Airline do
  before(:each) do
    @fronteir = Airline.create!(name: 'Fronteir')
    @southwest = Airline.create!(name: 'Southwest')

    @steve = Passenger.create!(name: 'Steve', age: 52)
    @meg = Passenger.create!(name: 'Meg', age: 18)
    @albert = Passenger.create!(name: 'Albert', age: 79)
    @ally = Passenger.create!(name: 'Ally', age: 13)

    @james = Passenger.create!(name: "James Potter", age: 43)

    @flight_1 = Flight.create!(number: 1, date: '08/03/21', departure_city: 'Denver', arrival_city: 'Portland', airline: @fronteir)
    @flight_2 = Flight.create!(number: 2, date: '08/15/21', departure_city: 'Indianapolis', arrival_city: 'San Francisco', airline: @fronteir)
    @flight_3 = Flight.create!(number: 3, date: '08/22/21', departure_city: 'Washington D.C.', arrival_city: 'San Francisco', airline: @fronteir)
    @flight_4 = Flight.create!(number: 4, date: '08/01/21', departure_city: 'Indianapolis', arrival_city: 'Denver', airline: @southwest)

    @flight_1.passengers << @steve
    @flight_1.passengers << @ally
    @flight_1.passengers << @meg

    @flight_2.passengers << @albert
    @flight_2.passengers << @steve

    @flight_3.passengers << @albert
    @flight_3.passengers << @steve

    @flight_4.passengers << @james
  end

  describe 'relationships' do
    it { should have_many(:flights) }
    it { should have_many(:passengers).through(:flights) }
  end

  describe 'instance methods' do
    it 'has distinct adult passengers' do
      expect(@fronteir.adult_passengers).to eq([@steve, @albert, @meg])
    end
  end
end
