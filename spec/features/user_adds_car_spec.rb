require 'spec_helper'

feature 'add car', %Q{
As a car salesperson
I want to record a newly acquired car
So that I can list it in my lost
} do

# ACCEPTANCE CRITERIA
# I must specify the color, year, mileage of the car.
# Only years from 1980 and above can be specified.
# I can optionally specify a description of the car.
# If I enter all of the required information in the required format, the car is recorded.
# If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
# Upon successfully creating a car, I am redirected so that I can create another car.

  scenario 'specify color,  year, mileage of car' do
    test = FactoryGirl.create(:car)

    visit '/cars/new'
    fill_in "Color", with: test.color
    fill_in "Year", with: test.year
    fill_in "Mileage", with: test.mileage
    click_on "Save Car"

    expect(page).to have_content(test.color)
    expect(page).to have_content(test.year)
    expect(page).to have_content(test.mileage)
  end

  scenario 'should allow creation if year >= 1980' do
    test = FactoryGirl.create(:car, year: 1990)

    visit '/cars/new'
    fill_in "Color", with: test.color
    fill_in "Year", with: test.year
    fill_in "Mileage", with: test.mileage
    click_on "Save Car"

    expect(page).to have_content(test.year)
    expect(page).to have_content('Car was successfully added.')
    expect(Car.count).to eq(2) # 1 object created in each scenario
  end

  scenario 'should not allow creation if year < 1980' do
    color = 'Red'
    year = 1979
    mileage = 12345

    visit '/cars/new'
    fill_in "Color", with: color
    fill_in "Year", with: year
    fill_in "Mileage", with: mileage
    click_on "Save Car"

    expect(page).to have_content('must be greater than or equal to 1980')
    expect(page).to_not have_content('Car was successfully added.')
  end

end
