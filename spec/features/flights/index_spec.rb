require 'rails_helper'

RSpec.describe 'flights index page', type: :feature do
  before(:each) do
    @fronteir = Airline.create!(name: 'Fronteir')
    @southwest = Airline.create!(name: 'Southwest')

    @steve = Passenger.create!(name: 'Steve', age: 52)
    @meg = Passenger.create!(name: 'Meg', age: 34)
    @albert = Passenger.create!(name: 'Albert', age: 79)
    @ally = Passenger.create!(name: 'Ally', age: 13)

    @flight_1 = Flight.create!(number: 1, date: '08/03/21', departure_city: 'Denver', arrival_city: 'Portland', airline: @fronteir)
    @flight_2 = Flight.create!(number: 2, date: '08/15/21', departure_city: 'Indianapolis', arrival_city: 'San Francisco', airline: @southwest)

    @flight_1.passengers << @steve
    @flight_1.passengers << @ally
    @flight_1.passengers << @meg

    @flight_2.passengers << @albert
    @flight_2.passengers << @steve
  end

  describe 'display' do
    it 'has flight attributes' do
      visit flights_path

      within("#flights-#{@flight_1.id}") do
        expect(page).to have_content(@flight_1.number)
        expect(page).to have_content(@fronteir.name)
        expect(page).to have_content(@steve.name)
        expect(page).to have_content(@ally.name)
        expect(page).to have_content(@meg.name)
      end
      within("#flights-#{@flight_2.id}") do
        expect(page).to have_content(@flight_2.number)
        expect(page).to have_content(@southwest.name)
        expect(page).to have_content(@steve.name)
        expect(page).to have_content(@albert.name)
      end
    end
  end

  describe 'links' do
    it 'has passenger removal links' do
      visit flights_path
    end
  end
end
