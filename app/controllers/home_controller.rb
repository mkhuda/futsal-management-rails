class HomeController < ApplicationController
  def index
  	@fp = FutsalPlace.take(3)
  end

  def show
  	@fp = FutsalPlace.find_by(id: params[:id])
  end

  def list

  end
end
