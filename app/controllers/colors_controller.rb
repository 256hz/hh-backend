class ColorsController < ApplicationController
  def index
    @colors = Color.all
    render json: @colors
  end

  def show
    @color = Color.find(params[:id])
    render json: @color
  end
end
