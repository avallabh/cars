class CarsController < ApplicationController

  def index
    @car = Car.all
  end

  def new
    @car = Car.new
  end

  def show
    @car = Car.find(params[:id])
  end

  def create
    @car = Car.new(params.require(:car).permit(:color, :year, :mileage, :description))
    if @car.save
      #render 'index', notice: 'Car was successfully added.'
      redirect_to '/cars', notice: 'Car was successfully added.'
    else
      render 'new'
    end
  end

end
