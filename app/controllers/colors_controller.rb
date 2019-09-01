class ColorsController < ApplicationController
  def index
    @colors = Color.all
    render json: @colors
  end

  def generate
    Color.generate(params[:amount].to_i)
    @colors = Color.all
    render json: @colors
  end
end
