require 'rails_helper'

RSpec.describe 'airline show page', type: :feature do
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
    @flight_3 = Flight.create!(number: 3, date: '08/01/21', departure_city: 'Indianapolis', arrival_city: 'Denver', airline: @southwest)

    @flight_1.passengers << @steve
    @flight_1.passengers << @ally
    @flight_1.passengers << @meg

    @flight_2.passengers << @albert
    @flight_2.passengers << @steve

    @flight_3.passengers << @james
  end

  describe 'display' do
    it 'lists all adult passengers only once' do
      visit airline_path(@fronteir.id)

      expect(page).to have_content("Fronteir")
      within('#passengers') do
        expect(page).to have_content(@steve.name, count: 1) #no duplicates
        expect(page).to have_content(@meg.name) #18 shows up
        expect(page).to have_content(@albert.name)
        expect(page).to_not have_content(@ally.name) #under 18 does not show up
        expect(page).to_not have_content(@james.name) #no other airlines passengers
      end
    end
  end
end
